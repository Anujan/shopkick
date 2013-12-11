Shopkick::Application.routes.draw do
  get "root/root"

  get '/sign_up', to: 'Stores#new'
  post '/sign_up', to: 'Stores#create'
  resources :stores, only: [:new, :create]

  get '/sign_in', to: "Sessions#new"
  post '/sign_in', to: "Sessions#create"
  resources :sessions, only: [:new, :create]

  root to: 'root#root'
end
