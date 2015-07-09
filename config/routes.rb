Rails.application.routes.draw do
  root 'pages#home'
  
  resources :movies
  resources :collections, only: [:create, :index, :destroy]
end
