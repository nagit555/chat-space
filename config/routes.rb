Rails.application.routes.draw do
  devise_for :users
  # :index,:create,:new,:edit,:show,:update,:destroy
  resources :users    , only: [:edit, :update]
  resources :groups   , only: [:new, :create, :edit, :update] do
    resources :messages , only: [:create]
  end
  resources :members  , only: [:create, :update]

  root 'messages#index'
end
