Rails.application.routes.draw do
  root 'front_pages#home'

  get 'about', to: 'front_pages#about', as: :about

  get   '/register',  to: 'registrations#new',    as: :registration
  post  '/register',  to: 'registrations#create', as: :registration_create

  get '/login',                   to: 'sessions#new',                 as: :login
  post '/login',                  to: 'sessions#create',              as: :login_create
  delete 'logout',                to: 'sessions#destroy',             as: :logout
  delete 'logout_all_sessions',   to: 'sessions#destroy_from_all',    as: :logout_all

  get '/users/:username', to: 'users#show', as: :users_show
  get '/users/:username/edit', to: 'users#edit', as: :users_edit
  patch '/users/:username/update', to: 'users#update', as: :users_update

  get 'dashboard', to: 'dashboards#show', as: :dashboard
end
