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
    post '/albums/login' => 'albums#login'
    delete '/albums/logout' => 'albums#logout'
  resources :photos
  resources :comments

  namespace :admin do
    resources :users
      # match 'users/destroy_all', to: 'users#destroy_all', via: :delete
      delete 'users/destroy_all' => 'users#destroy_all'
    resources :albums
    resources :photos
    resources :comments
  end


end
