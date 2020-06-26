Rails.application.routes.draw do
  devise_for :users, controllers: {registrations: "registrations"}

  authenticated :user do
    root to: "matches#index", as: :authenticated_root
  end

  devise_scope :user do
    get "/add_info", to: "registrations#add_info", as: "add_information"
    get "/add_image", to: "registrations#add_image", as: "add_image"
    patch "/add_info", to: "registrations#update_info", as: "update_information"
    patch "/add_image", to: "registrations#update_image", as: "update_image"
    get "/show", to: "registrations#show", as: "show"
  end

  root to: "home#index"

  resources :matches

  get "/add_userinterests", to: "userinterests#add_userinterests", as: "add_userinterests"
  post "/add_userinterests", to: "userinterests#update"
  get "/confirmation", to: "matches#confirmation"
end
