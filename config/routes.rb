Rails.application.routes.draw do
  root 'home#index'
  get '/home', to: 'home#index'
  get '/contact', to: 'home#contact'
  devise_for :users
  resources :admin_users
  resources :basic_informations
  resources :user_contacts
  resources :student_classes
  resources :relationships
end
