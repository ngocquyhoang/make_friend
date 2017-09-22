Rails.application.routes.draw do
  root to: 'home#index'

  namespace :admins do
    resources :dashboard, only: [:index]
  end

  devise_for :admins, path: 'admins', controllers: { 
    sessions: 'admins/sessions',
    passwords: 'admins/passwords',
    registrations: 'admins/registrations'
  }


  namespace :users do
    resources :dashboard, only: [:index]
  end
  
  devise_for :users, path: 'users', controllers: { 
    sessions: 'users/sessions',
    passwords: 'users/passwords',
    registrations: 'users/registrations' 
  }
end
