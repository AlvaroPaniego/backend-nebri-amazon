Rails.application.routes.draw do
  namespace :api, defaults: { format: :json } do
    # Authentication
    post 'auth/register', to: 'authentication#register'
    post 'auth/login', to: 'authentication#login'
    get  'auth/me', to: 'authentication#me'

    # Categories
    resources :categories, only: [:index, :show]

    # Products
    resources :products, only: [:index, :show, :create, :update, :destroy]

    # Cart (singleton)
    resource :cart, only: [:show] do
      resources :items, controller: 'cart_items', only: [:create, :update, :destroy]
    end

    # Orders
    resources :orders, only: [:index, :show, :create]

    # Chatbot (optional placeholder)
    post 'chatbot', to: 'chatbot#process_message'
  end
end
