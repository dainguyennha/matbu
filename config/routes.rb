Rails.application.routes.draw do
    # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'products#index'
  namespace :auth do
    resources :signups, only: [:new, :create]
    resources :sessions, only: [:new, :create, :destroy]
  end
  get '/cart_products', to: 'card_products#show_all', as: 'ct_product'
  resources :users, only: [:update, :show]
  resources :products
  resources :comments
  resources :card_products
end
