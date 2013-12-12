Shopkick::Application.routes.draw do
  constraints(lambda { |r| r.subdomain.present? && r.subdomain != 'www' }) do
    namespace :admin do
      root to: 'Dashboard#index'
      resources :orders
      resources :customers
      resources :products
    end
    scope module: 'store' do
      root to: 'Main#index'
    end
  end

  get '/sign_up', to: 'Stores#new'
  post '/sign_up', to: 'Stores#create'
  resources :stores, only: [:new, :create]

  get '/sign_in', to: "Sessions#new"
  post '/sign_in', to: "Sessions#create"
  resources :sessions, only: [:new, :create, :destroy]

  root to: 'Sessions#new'
end
