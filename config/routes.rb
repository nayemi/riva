Rails.application.routes.draw do

  get 'password_resets/new'
  get 'password_resets/edit'
  root 'static_pages#home'

  get  '/help',    to: 'static_pages#help'
  get  '/about',   to: 'static_pages#about'
  get  '/contact', to: 'static_pages#contact'
  get  '/signup',  to: 'users#new'

  get   '/login',  to: 'sessions#new'
  post  '/login',  to: 'sessions#create'
  delete'/logout', to: 'sessions#destroy'

  # Example:
  # creates seven different routes in your application, all mapping to
  # the +Photos+ controller:
  #
  #   GET       /photos
  #   GET       /photos/new
  #   POST      /photos
  #   GET       /photos/:id
  #   GET       /photos/:id/edit
  #   PATCH/PUT /photos/:id
  #   DELETE    /photos/:id
  #

  resources :account_activations, only: [:edit]
  resources :password_resets,     only: [:new, :create, :edit, :update]
  resources :microposts,          only: [:create, :destroy]
  resources :relationships,       only: [:create, :destroy]

  # member method:
  resources :users do
    member do
      get :following, :followers
    end
  end

end
