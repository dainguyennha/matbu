Rails.application.routes.draw do
    # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'products#index'
  namespace :auth do
    resources :signups, only: [:new, :create]
    resources :sessions, only: [:new, :create, :destroy]
    get '/signups_page', to: 'signups#new_page'
    get '/signins_page', to: 'sessions#new_page'
  end
  get '/cart_products', to: 'card_products#show_all', as: 'ct_product'

  get '/products/search', to: 'products#search', as: 'search_products'
  get '/products/category', to: 'products#category', as: 'category_products'
  get '/products/filter', to: 'products#filter', as: 'filter_products'

  get '/orders/sys', to: 'orders#index_sys', as: 'sys_orders'
  get '/order/sys/:id', to: 'orders#show_sys', as: 'sys_order'
  put '/order/sys/:id', to: 'orders#update_status_sys', as: 'sys_update_status_order'
  get '/sys/sales_statistics', to: 'orders#sales_statistics', as: 'sys_sales_statistics'
  post '/sys/statistics_by_date_or_month', to: 'orders#statistics_by_date_or_month', as: 'statistics_by_date_or_month'

  resources :users, only: [:update, :show]
  resources :products
  resources :comments
  resources :orders
  resources :card_products
end
