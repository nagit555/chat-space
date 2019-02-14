Rails.application.routes.draw do
  devise_for :users
  # :index,:create,:new,:edit,:show,:update,:destroy
  resources :users    , only: [:edit, :update]
  resources :groups
  resources :members
  resources :messages

  root 'messages#index'
end
