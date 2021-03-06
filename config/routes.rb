Rails.application.routes.draw do
  root to: 'home#index'

  namespace :users do
    resources :dashboard, only: [:index]
    
    devise_scope :user do 
      get '/password/send_instructions' => 'passwords#send_instructions_successfull', as: 'send_instructions_successfull'
    end
  end

  patch 'update_information/:id', to: 'users#update_information', as: 'update_information'
  put 'update_information/:id', to: 'users#update_information'

  patch 'upload_avatar/:id', to: 'users#upload_avatar', as: 'upload_avatar'
  put 'upload_avatar/:id', to: 'users#upload_avatar'

  resources :relationships, only: [:create, :destroy]
  post 'accept_friend', to: 'relationships#accept_friend', as: 'accept_friend'
  post 'refused_friend', to: 'relationships#refused_friend', as: 'refused_friend'

  post 'update_status', to: 'users#update_status', as: 'update_status'

  post 'get_district_ajax', to: 'users#get_district_ajax', as: 'get_district_ajax'
  post 'get_commune_ajax', to: 'users#get_commune_ajax', as: 'get_commune_ajax'
  post 'get_highschool_district_ajax', to: 'users#get_highschool_district_ajax', as: 'get_highschool_district_ajax'
  post 'get_highschool_list_ajax', to: 'users#get_highschool_list_ajax', as: 'get_highschool_list_ajax'
  post 'check_username_ajax', to: 'users#check_username_ajax', as: 'check_username_ajax'
  post 'delete_status_ajax', to: 'users#delete_status_ajax', as: 'delete_status_ajax'

  get ':username', to: 'users#show', as: :user
  
  devise_for :users, path: 'users', controllers: { 
    sessions: 'users/sessions',
    passwords: 'users/passwords',
    registrations: 'users/registrations',
    confirmations: 'users/confirmations',
    unlocks: 'users/unlocks',
  }
end
