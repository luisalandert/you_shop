Rails.application.routes.draw do
  devise_for :users
  root to: 'home#index'
  get '/register', to: 'home#register'
  devise_for :admins
  resources :companies, only: [:index, :show, :new, :create]
  resources :users, only: [:show, :edit, :update]
  resources :products, only: [:index, :show, :new, :create, :edit, :update] do
    resources :comments, only: [:create]
    resources :messages, only: [:new, :create]
    get 'search', on: :collection
  end
  resources :proposals, only: [:index, :show, :new, :create] do
    get 'received', on: :collection
    get 'sent', on: :collection
    get 'cancelled', on: :collection
    get 'rejected', on: :collection
    post 'accept', on: :member
    post 'deny', on: :member
    post 'cancel', on: :member
  end
  resources :invoices, only: [:index, :show]
end
