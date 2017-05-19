Rails.application.routes.draw do
  root 'front_pages#home'

  get 'about', to: 'front_pages#about', as: :about

  get   '/register',  to: 'registrations#new',    as: :registration
  post  '/register',  to: 'registrations#create', as: :registration_create

  get '/login',     to: 'sessions#new',       as: :login
  post '/login',    to: 'sessions#create',    as: :login_create
  delete 'logout',  to: 'sessions#destroy',   as: :logout

  resources :users

  get 'dashboard', to: 'dashboards#show', as: :dashboard
end
