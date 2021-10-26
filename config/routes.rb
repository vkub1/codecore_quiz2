Rails.application.routes.draw do
  resources :ideas do
    resources :reviews, only: [:create, :destroy]
    resources :likes, shallow: true, only:[:create, :destroy]
  end

  resources :users, only: [:new, :create]

  resource :session, only: [:new, :create, :destroy]

  get('/', {to: "ideas#index"})

end
