Rails.application.routes.draw do
  resource :session
  resources :passwords, param: :token
  root "tags#index"

  resources :tags
end
