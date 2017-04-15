Rails.application.routes.draw do
  root to: 'bookmarks#index'

  match 'login', to: 'sessions#new', via: [:get]
  match 'auth/:provider/callback', to: 'sessions#create', via: [:get, :post]
  match 'auth/failure', to: redirect('/'), via: [:get, :post]
  match 'signout', to: 'sessions#destroy', as: 'signout', via: [:get, :post]

  resources :bookmarks
end
