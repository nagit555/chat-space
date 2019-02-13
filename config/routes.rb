Rails.application.routes.draw do
  # :index,:create,:new,:edit,:show,:update,:destroy
  resources :users    #, only: []
  resources :groups
  resources :members
  resources :messages

  root 'messages#index'
end
