Rails.application.routes.draw do

  root 'homes#index'
  post 'home/guest' => 'homes#guest'

  devise_for :admins, controllers: {
  sessions:      'admins/sessions',
  passwords:     'admins/passwords',
  registrations: 'admins/registrations'
  }
  devise_for :users, controllers: {
    sessions:      'users/sessions',
    passwords:     'users/passwords',
    registrations: 'users/registrations'
  }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :users
  resources :albums
  resources :photos
  resources :comments

  namespace :admin do
    resources :users
    resources :albums
  end


end
