Rails.application.routes.draw do
  get 'sessions/new'
  root 'static_pages#home'
  get '/home', to: 'static_pages#home'
  get '/help', to: 'static_pages#help'

  get '/rider_signup', to: 'riders#new'
  post '/rider_signup', to: 'riders#create'
  get '/driver_signup', to: 'drivers#new'
  post '/driver_signup', to: 'drivers#create'

  get    '/rider_login',   to: 'sessions#rider_new'
  post   '/rider_login',   to: 'sessions#rider_create'
  delete '/rider_logout',  to: 'sessions#rider_destroy'
  get    '/driver_login',   to: 'sessions#driver_new'
  post   '/driver_login',   to: 'sessions#driver_create'
  delete '/driver_logout',  to: 'sessions#driver_destroy'

  resources :riders
  resources :drivers
  resources :routes
  resources :rides 
  resources :relationships
end
