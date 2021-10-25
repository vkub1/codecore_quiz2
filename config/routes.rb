Rails.application.routes.draw do
  resources :ideas

  resources :users, only: [:new, :create]

  resources :session, only: [:new, :create, :destroy]

end
