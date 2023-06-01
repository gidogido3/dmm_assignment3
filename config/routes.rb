Rails.application.routes.draw do
  get 'users/edit'
  get 'users/index'
  get 'users/show'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: "homes#top"
  devise_for :users
  resources :books, only: [:new, :create, :index, :show]
  resources :users, only: [:show, :edit]
end
