Rails.application.routes.draw do
  root 'pages#home'
  
  get '/auth/facebook/callback', to: 'sessions#create'
  get 'log-out', to: 'sessions#destroy'

  resources :movies
  resources :collections, only: [:create, :index, :destroy]
end
