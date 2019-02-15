Rails.application.routes.draw do
  devise_for :users
  # :index,:create,:new,:edit,:show,:update,:destroy
  resources :users    , only: [:edit, :update]
  resources :groups   , only: [:index, :new, :create, :edit, :update] do
    resources :messages , only: [:index, :create]
  end
  resources :members  , only: [:create, :update]

  root 'groups#index'
end
