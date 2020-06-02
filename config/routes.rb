Rails.application.routes.draw do
  # get 'home/index'
  devise_for :users, :controllers => {registrations: "registrations"}
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  devise_scope :user do
    get "/add_info" => "registrations#add_info", :as => "add_information"
    get "/add_image" => "registrations#add_image", :as => "add_image"
  end

  get "/add_interests" => "interests#add_interests", :as => "add_interests"

  root to: "home#index"

  # get '/tell_us_about', to: 'information#tell_us_about_yourself'
  # get '/interests', to: 'information#interests'
  # get '/profile_show', to: 'profiles#show'
  # get '/confirmation', to: 'information#confirmation'
end
