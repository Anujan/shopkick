Shopkick::Application.routes.draw do
  get "root/root"

  get '/sign_up', to: 'Stores#new'
  post '/sign_up', to: 'Stores#create'
  resources :stores, only: [:new, :create]

  get '/sign_in', to: "Sessions#new"
  post '/sign_in', to: "Sessions#create"
  resources :sessions, only: [:new, :create, :destroy]

  root to: 'root#root'

  constraints(lambda { |r| r.subdomain.present? && r.subdomain != 'www' }) do
    namespace :admin do
      get '/', to: 'Dashboard#index'
      resources :orders
      resources :customers
      resources :products
    end
  end
end
