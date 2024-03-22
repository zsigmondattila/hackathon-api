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

    private

    # helper method to access the current user from the token
    def current_user
      @current_user ||= User.find_by(id: doorkeeper_token[:resource_owner_id])
    end
end
