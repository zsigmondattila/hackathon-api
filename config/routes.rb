Rails.application.routes.draw do
  use_doorkeeper do
    skip_controllers :authorizations, :applications, :authorized_applications
  end
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  namespace :v1 do
    post '/registration', to: 'users#create'
    get '/user_data', to: 'users#show'

    get '/test', to: 'application#test'
    get '/get_counties', to: 'application#get_counties'
    get '/get_cities_in_county', to: 'application#get_cities_in_county'
    get '/get_collect_points', to: 'application#get_collect_points'
  end
end
