Rails.application.routes.draw do
  root 'home#index'
  get '/home', to: 'home#index'
  get '/contact', to: 'home#contact'

  get '/provinces', to: 'home#provinces'
  get '/provinces/:code/districts', to: 'home#districts'
  get '/districts/:code/wards', to: 'home#wards'

  devise_for :users
  resources :admin_users
  resources :basic_informations
  get '/basic_informations/:id/edit_user_contact', to: 'basic_informations#edit_user_contact', as: 'edit_user_contact'
  patch '/basic_informations/:id/update_user_contact', to: 'basic_informations#update_user_contact', as: 'update_user_contact'
  get '/basic_informations/:id/edit_relationship', to: 'basic_informations#edit_relationship', as: 'edit_relationship'
  patch '/basic_informations/:id/update_relationship', to: 'basic_informations#update_relationship', as: 'update_relationship'
  resources :user_contacts
  resources :student_classes
  resources :relationships
end
