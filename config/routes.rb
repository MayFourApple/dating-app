Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  resource :user do
    scope module: 'users' do
      resource :location
      resource :gender
    end
  end

  resources :schedules
  resources :conversations do
    resources :messages
  end

  resources :matches

  get "sessions/destroy"

  controller :sessions do
  get 'logout' => :destroy  
  end

  # Defines the root path route ("/")
  root "homepage#index"
  get "dashboard", to: "dashboard#index"

end
