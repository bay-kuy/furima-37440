Rails.application.routes.draw do
  devise_for :users
  root to: 'items#index'
  resources :items
  resources :deal_logs, only: [:index]
end
