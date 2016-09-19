Rails.application.routes.draw do

  root 'welcome#index'

  resources :sessions, only: [:index, :new, :destroy, :create]
  get 'login' => 'sessions#new'
  get 'logout' => 'sessions#destroy'

  resources :welcome, only: [:index]

  resources :admin, only: [:index] do
    collection do
      get :upload
      get :album
    end
  end

end
