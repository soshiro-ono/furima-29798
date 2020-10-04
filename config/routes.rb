Rails.application.routes.draw do
  root to: 'items#index'
  devise_for :users
  resources :items
  get 'posts/:id', to: 'items#input'
end

