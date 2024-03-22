class V1::ApplicationController < ApplicationController
    before_action :authenticate_user!
    def test
        render json: { message: 'Hello World' }
    end
end
