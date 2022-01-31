Rails.application.routes.draw do
  get 'sessions/new'
  get 'sessions/create'
  get 'sessions/destroy'

#  get 'users/index'
#  get 'users/show'
#  get 'users/new'
  get 'users/create'

  root to: 'tasks#index'
  
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  
  get 'signup', to: 'users#new'

#  resources :users, only: [:index, :show, :create]
  resources :users, only: [:create]

  resources :tasks
end
