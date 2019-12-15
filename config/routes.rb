Rails.application.routes.draw do
  resources :recipe_lists
  resources :meals do
    post 'add_to_shopping_list', to: 'meals#add_to_shopping_list', as: :add_to_shopping_list
  end
  devise_for :users
  root 'recipes#index'
  resources :recipes
  resources :products
  resources :users, only: [:show]
  resources :shopping_lists do
    post 'add_meal', to: 'shopping_lists#add_meal', as: :add_meal
    post 'remove_meal', to: 'shopping_lists#remove_meal', as: :remove_meal
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
