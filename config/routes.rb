Rails.application.routes.draw do
  root to: 'public#index'

  devise_for :users

  resources :users
  resources :recipes do
    resources :recipe_foods
  end
  resources :foods
  
end
