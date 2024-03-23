class V1::UsersController < V1::ApplicationController
    skip_before_action :doorkeeper_authorize!, only: %i[create show]

    def create
        user = User.new(user_params)
      
        client_app = Doorkeeper::Application.find_by(uid: params[:client_id])
      
        return render(json: { error: 'Invalid client ID'}, status: 403) unless client_app
      
        if user.save
          access_token = Doorkeeper::AccessToken.create(
            resource_owner_id: user.id,
            application_id: client_app.id,
            refresh_token: generate_refresh_token,
            expires_in: 2.days.to_i,
            scopes: ''
          )
          
          render(json: {
            user: {
              id: user.id,
              email: user.email,
              firstname: user.firstname,
              lastname: user.lastname,
              phone_number: user.phone_number,
              city: City.find_by(id: user.city_id),
              access_token: access_token.token,
              token_type: 'bearer',
              expires_in: 2.days.to_i,
              refresh_token: access_token.refresh_token,
              created_at: access_token.created_at.to_time.to_i
            }
          })
        else
          render(json: { error: user.errors.full_messages }, status: 422)
        end
      end

      def show
        if doorkeeper_token
          user = current_resource_owner
          if user
            render(json: {
              user: {
                id: user.id,
                email: user.email,
                firstname: user.firstname,
                lastname: user.lastname,
                phone_number: user.phone_number,
                balance: user.balance,
                leaderboard_position: user.leaderboard_position,
                city: City.find_by(id: user.city_id)
              }
            })
          else
            render(json: { error: 'User not found' }, status: 404)
          end
        else
          render(json: { error: 'Unauthorized' }, status: 401)
        end
      end      

    private

    def user_params
        params.permit(:email, :password, :firstname, :lastname, :phone_number, :city_id)
    end

    def generate_refresh_token
      loop do
        # generate a random token string and return it, 
        # unless there is already another token with the same string
        token = SecureRandom.hex(32)
        break token unless Doorkeeper::AccessToken.exists?(refresh_token: token)
      end
    end 

    def current_resource_owner
        User.find(doorkeeper_token.resource_owner_id) if doorkeeper_token
    end
  end
