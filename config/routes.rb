Rails.application.routes.draw do
  devise_for :users
  root 'recipes#index'
  resources :recipes
  resources :products
  resources :users, only: [:show]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
