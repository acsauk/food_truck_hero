Rails.application.routes.draw do
  resources :recipe_lists
  resources :meals do
    post 'add_to_shopping_list', to: 'meals#add_to_shopping_list', as: :add_to_shopping_list
    collection do
      match 'search' => 'meals#search', via: [:get, :post], as: :search
      match 'search_async' => 'meals#search_async', via: [:get, :post], as: :search_async
    end
  end
  devise_for :users
  root 'recipes#index'
  resources :recipes do
    collection do
      match 'search' => 'recipes#search', via: [:get, :post], as: :search
      match 'search_async' => 'recipes#search_async', via: [:get, :post], as: :search_async
    end
  end
  resources :products do
    collection do
      match 'search' => 'products#search', via: [:get, :post], as: :search
      match 'search_async' => 'products#search_async', via: [:get, :post], as: :search_async
    end
  end
  resources :users, only: [:show]
  resources :shopping_lists do
    post 'add_meal', to: 'shopping_lists#add_meal', as: :add_meal
    post 'remove_meal', to: 'shopping_lists#remove_meal', as: :remove_meal
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
