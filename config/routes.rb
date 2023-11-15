Rails.application.routes.draw do
  root to: 'public#index'

  devise_for :users

  resources :users
  resources :recipes
  resources :foods
  resources :recipe_foods
  
end
