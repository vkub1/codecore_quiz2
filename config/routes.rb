Rails.application.routes.draw do
  resources :ideas, only: [:new, :create, :show]
end
