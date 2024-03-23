class V1::ApplicationController < ApplicationController
    before_action :doorkeeper_authorize!, except: [:test, :print_voucher, :get_counties, :get_cities_in_county, :get_collect_points, :create_achievement, :list_of_achievements, :add_points_to_user, :get_user_points]

    def test
        render json: { message: 'Hello World' }
    end

    def get_counties
        counties = City.pluck(:county).uniq
        render json: {counties: counties}
    end

    def get_cities_in_county
        cities = City.find_by(county: params[:county])
        render json: {cities: cities}
    end

    def get_collect_points
        new_data = []
        cps = CollectPoint.all.map do |cp|
        city = City.find(cp.city_id)
        new_data << { id: cp.id,
                      collection_type: cp.collection_type,
                      name: cp.name,
                      address: cp.address,
                      longitude: cp.longitude, 
                      latitude: cp.latitude,
                      city: city.name,
                      contact_phone: cp.contact_phone,
                    }
        end
        render json: {collect_points: new_data}
    end

    def get_vouchers_for_user
        user = current_user
        user_vouchers = UserVoucher.where(user_id: user.id).includes(:voucher)
        
        vouchers = user_vouchers.map(&:voucher)
        
        render json: { vouchers: vouchers }
      end
      

    def print_voucher
        partner_id_formatted = sprintf('%03d', params[:partner_id])
        value_formatted = sprintf('%.2f', params[:value]).delete('.').rjust(5, '0')
        random_numbers = SecureRandom.random_number(100_000).to_s.rjust(5, '0')
        barcode = "#{partner_id_formatted} #{random_numbers} #{value_formatted} #{SecureRandom.random_number(100).to_s.rjust(2, '0')}"
        puts barcode
        
        v = Voucher.create(
          value: params[:value],
          valability: Time.now + 1.month,
          barcode: barcode,
          is_valid: true,
          partner_id: params[:partner_id]
        )
      
        if v.save
          render json: { message: 'Voucher printed' , barcode: barcode}
        else
          render json: { error: v.errors.full_messages }
        end
      end    

      def add_user_voucher
        user = current_user
        voucher = Voucher.find_by(barcode: params[:barcode])
      
        if voucher
          user_voucher = UserVoucher.new(user_id: user.id, voucher_id: voucher.id)
          
          if user_voucher.save
            user.balance += voucher.value
            
            if user.save
              render json: { message: 'Voucher scanned', new_balance: user.balance }
            else
              render json: { error: user.errors.full_messages, message: 'User balance update failed' }, status: :unprocessable_entity
            end
          else
            render json: { error: user_voucher.errors.full_messages, message: 'UserVoucher creation failed' }, status: :unprocessable_entity
          end
        else
          render json: { message: 'Voucher not found' }, status: :not_found
        end
      end
      

    def use_user_voucher
        user = current_user
        barcode = params[:barcode]
        
        voucher = Voucher.find_by(barcode: barcode)
        puts "Voucher found: #{voucher} for barcode: #{barcode} last voucher: #{Voucher.last.barcode}"
        
        if voucher && voucher.is_valid
          user_voucher = UserVoucher.find_by(user_id: user.id, voucher_id: voucher.id)
      
          if user_voucher
            if user.balance >= voucher.value
              voucher.is_valid = false
              voucher.save!
        
              user.balance -= voucher.value
              user.save!
        
              render json: { message: 'Voucher used' }, status: :accepted
            else
              render json: { message: 'Insufficient balance' }, status: :forbidden
            end
          else
            render json: { message: 'Voucher not found for the current user' }, status: :not_found
          end
        else
          render json: { message: 'Voucher not found or already used' }, status: :not_found
        end
      end
      
      

    def create_achievement
        user = current_user
        achievement = Achievement.find(params[:achievement_id])
        s = Scoreboard.create(user_id: user.id, points: achievement.point_value, points_date: Time.now)
        s.save
        EarnedAchievement.create(user_id: user.id, achievement_id: params[:achievement_id])
        
        render json: { message: "Achievements earned successfully" }, status: :ok
    end

    def list_of_achievements
        user = current_user
        earned = params[:earned] == "true"
        
        if earned
          achievements = user.earned_achievements.map do |ea|
            achievement = Achievement.find(ea.achievement_id)
            { 
              id: achievement.id,
              name: achievement.name,
              description: achievement.description,
              points: achievement.point_value 
            }
          end
          render json: { earned_achievements: achievements }
        else
          unearned_achievement_ids = Achievement.pluck(:id) - user.earned_achievements.pluck(:achievement_id)
          unearned_achievements = Achievement.where(id: unearned_achievement_ids)
          achievements = unearned_achievements.map do |achievement|
            { 
              id: achievement.id,
              name: achievement.name,
              description: achievement.description,
              points: achievement.point_value
            }
          end
          render json: { unearned_achievements: achievements } 
        end
    end      

    def add_points_to_user
        user = current_user
        user.scoreboard.create(points: params[:points], points_date: Time.now)

        render json: { message: 'Points added' , current_points: user.scoreboard.sum(:points)}
    end
      
    def get_user_points
        user = User.find_by(email: params[:email])
        if !user
            user = current_user
        end
        weekly_points = user.scoreboard.where("points_date >= ?", 1.week.ago).sum(:points)
        monthly_points = user.scoreboard.where("points_date >= ?", 1.month.ago).sum(:points)
        total_points = user.scoreboard.sum(:points)
        
        render json: { user_id: user.id, Weekly_Points: weekly_points, Monthly_Points: monthly_points, Total_Points: total_points }
    end

    def generate_coupon
        user = current_user
        code = SecureRandom.alphanumeric(8).upcase
        if user.balance < params[:value].to_d
            render json: { message: 'Insufficient balance' }
        else
            user.balance -= params[:value].to_d
            user.save
            c = Coupon.create(user_id: user.id, code: code, value: params[:value], valid_until: Time.now + 1.month, partner_id: params[:partner_id])
            if c.save
                render json: { message: 'Coupon generated' }
            else
                render json: { error: c.errors.full_messages }
            end
        end
    end

    def leaderboard
        weekly_leaderboard = generate_leaderboard(7.days.ago, Time.now)
      
        monthly_leaderboard = generate_leaderboard(1.month.ago, Time.now)
      
        total_leaderboard = generate_leaderboard(nil, nil)
      
        render json: {
          weekly_leaderboard: weekly_leaderboard,
          monthly_leaderboard: monthly_leaderboard,
          total_leaderboard: total_leaderboard
        }
    end

    def get_rewards
        rewards = Reward.all
        render json: { rewards: rewards }
    end

    private

    # helper method to access the current user from the token
    def current_user
      @current_user ||= User.find_by(id: doorkeeper_token[:resource_owner_id])
    end

    def generate_leaderboard(start_date, end_date)
        scoreboard_data = Scoreboard.where(points_date: start_date..end_date)
                                    .group(:user_id)
                                    .sum(:points)
                                    .sort_by { |_user_id, points| -points }
        
        leaderboard = []
        scoreboard_data.each_with_index do |(user_id, points), index|
          user = User.find(user_id)
          if start_date.nil? && end_date.nil?
            user.leaderboard_position = index + 1
            user.save
          end
          leaderboard << { rank: index + 1, user_id: user_id, firstname: user.firstname, lastname: user.lastname, points: points }
        end
        leaderboard
    end
end
