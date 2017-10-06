Rails.application.routes.draw do
  root to: 'home#index'

  namespace :admins do
    resources :dashboard, only: [:index]
  end

  devise_for :admins, path: 'admins', skip: :registrations, controllers: { 
    sessions: 'admins/sessions',
    passwords: 'admins/passwords',
  }

  namespace :users do
    resources :dashboard, only: [:index]
    
    devise_scope :user do 
      get '/password/send_instructions' => 'passwords#send_instructions_successfull', as: 'send_instructions_successfull'
    end
  end
  
  devise_for :users, path: 'users', controllers: { 
    sessions: 'users/sessions',
    passwords: 'users/passwords',
    registrations: 'users/registrations',
    confirmations: 'users/confirmations',
    unlocks: 'users/unlocks',
  }
end
