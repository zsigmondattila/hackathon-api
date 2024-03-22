class V1::ApplicationController < ApplicationController
    #before_action :doorkeeper_authorize!, except: [:test]

    def test
        render json: { message: 'Hello World' }
    end

    def get_counties
        counties = City.pluck(:county).uniq
        render json: {Counties: counties}
    end

    def get_cities_in_county
        cities = City.find_by(county: params[:county])
        render json: {Cities: cities}
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
        render json: {Collect_Points: new_data}
    end

    def scan_voucher
        user = current_user
        user.vouchers.create(value: params[:value], valability: Time.now + 1.month, barcode: params[:barcode], is_valid: true, partner_id: params[:partner_id])
        user.balance += params[:value].to_i
        render json: { message: 'Voucher scanned' }
    end

    def use_voucher
        user = current_user
        voucher = user.vouchers.find_by(barcode: params[:barcode])
        if voucher.is_valid
            voucher.is_valid = false
            user.balance -= voucher.value
            render json: { message: 'Voucher used' }
        else
            render json: { message: 'Voucher already used' }
        end
    end

    def create_achievement
        user = current_user
        EarnedAchievement.create(user_id: user.id, achievement_id: params[:achievement_id])
        
        render json: { message: "Achievements earned successfully" }, status: :ok
    end

    def list_of_achievements
        user = current_user
        earned = params[:earned] == "true"
        
        if earned
          achievements = user.earned_achievements.map do |ea|
            achievement = Achievement.find(ea.achievement_id)
            { id: achievement.id,
              name: achievement.name,
              description: achievement.description,
              points: achievement.points
            }
          end
          render json: { Earned_Achievements: achievements }
        else
          unearned_achievements = Achievement.where.not(id: user.earned_achievements.pluck(:achievement_id))
          achievements = unearned_achievements.map do |achievement|
            { id: achievement.id,
              name: achievement.name,
              description: achievement.description,
              points: achievement.points
            }
          end
          render json: { Unearned_Achievements: achievements }
        end
    end

    def add_points_to_user
        user = current_user
      
        user.scoreboard.create(points: params[:points], date: Time.now)
      end
      
    def get_user_points
    user = current_user
    weekly_points = user.scoreboard.where("date >= ?", 1.week.ago).sum(:points)
    monthly_points = user.scoreboard.where("date >= ?", 1.month.ago).sum(:points)
    total_points = user.scoreboard.sum(:points)
    
    render json: { Weekly_Points: weekly_points, Monthly_Points: monthly_points, Total_Points: total_points }
    end

    private

    # helper method to access the current user from the token
    def current_user
      @current_user ||= User.find_by(id: doorkeeper_token[:resource_owner_id])
    end
end
