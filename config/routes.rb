Rails.application.routes.draw do
  devise_for :users
  root to: 'home#index'
  get '/register', to: 'home#register'
  devise_for :admins
  resources :companies, only: [:index, :show, :new, :create]
end
