Rails.application.routes.draw do
  devise_for :admins
  root to: 'home#index'
  resources :company, only: [:index, :show]
end
