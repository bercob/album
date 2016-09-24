Rails.application.routes.draw do

  root 'photo_albums#index'

  resources :sessions, only: [:index, :new, :destroy, :create]
  get 'login' => 'sessions#new'
  get 'logout' => 'sessions#destroy'

  resources :photos, only: [:destroy]

  resources :photo_albums, only: [:index, :new, :destroy, :create, :show]

  resources :admin, only: [:index]

  get 'photo_albums/:album', to: 'photo_albums#index'

end
