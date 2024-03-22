class V1::ApplicationController < ApplicationController
    def test
        render json: { message: 'Hello World' }
    end
end
