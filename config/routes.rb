Rails.application.routes.draw do

  root 'photos#index'

  resources :sessions, only: [:index, :new, :destroy, :create]
  get 'login' => 'sessions#new'
  get 'logout' => 'sessions#destroy'

  resources :photos, only: [:index, :new, :destroy, :create]

  resources :admin, only: [:index]

end
