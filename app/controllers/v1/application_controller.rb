class V1::ApplicationController < ApplicationController
    before_action :doorkeeper_authorize!, except: [:test]

    def test
        render json: { message: 'Hello World' }
    end

    def get_collect_points
        new_data = []
        cps = CollectPoint.all.map do |cp|
        new_data << { id: cp.id,
                        name: cp.name,
                        address: cp.address,
                        longitude: cp.longitude, 
                        latitude: cp.latitude, }
        end
        render json: {Collect_Points: new_data}
      end

    private

    # helper method to access the current user from the token
    def current_user
      @current_user ||= User.find_by(id: doorkeeper_token[:resource_owner_id])
    end
end
