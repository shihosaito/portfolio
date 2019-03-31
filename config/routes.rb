Rails.application.routes.draw do

  root 'homes#index'
  get 'home/about' => 'homes#about'
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

  resources :users, only: [:show, :edit, :destroy]
  resources :albums
    post '/albums/login' => 'albums#login'
  resources :photos, except: [:index, :show]
  resources :comments, only: [:create, :destroy]

  namespace :admin do
    resources :users
      delete '/users' => 'users#destroy_all'
    resources :albums, except: [:new]
    resources :photos, only: [:destroy]
    resources :comments, only: [:create, :destroy]
  end

end
