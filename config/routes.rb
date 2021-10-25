Rails.application.routes.draw do
  resources :ideas

  resources :users, only: [:new, :create]

  resources :sessions, only: [:new, :create, :destroy]

end
