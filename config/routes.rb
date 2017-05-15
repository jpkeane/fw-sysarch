Rails.application.routes.draw do
  root 'front_pages#home'

  get 'about', to: 'front_pages#about', as: :about

  get   '/register',  to: 'registrations#new',    as: :registration
  post  '/register',  to: 'registrations#create', as: :registration_create

  get 'users/:username', to: 'users#show', as: :users_show
end
