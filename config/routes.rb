Rails.application.routes.draw do
  root 'home#index'
  get '/home', to: 'home#index'
  get '/contact', to: 'home#contact'

  get '/provinces', to: 'home#provinces'
  get '/provinces/:code/districts', to: 'home#districts'
  get '/districts/:code/wards', to: 'home#wards'

  devise_for :users

  resources :admin_users do
    collection do
      get :execute_users
      get :download_csv
    end
  end
  get '/import_student', to: 'admin_users#import_student', as: 'import_student'
  get '/student_sample', to: 'admin_users#student_sample', as: 'student_sample'
  post '/update_import_student', to: 'admin_users#update_import_student', as: 'update_import_student'
  get '/import_student_class', to: 'admin_users#import_student_class', as: 'import_student_class'
  post '/update_import_student_class', to: 'admin_users#update_import_student_class', as: 'update_import_student_class'
  get '/student_classes_sample', to: 'admin_users#student_classes_sample', as: 'student_classes_sample'
  get '/students_sample', to: 'admin_users#students_sample', as: 'students_sample'
  post '/delete_student', to: 'admin_users#delete_student', as: 'delete_student'


  resources :basic_informations do
    collection do
      patch 'update_password', to: 'basic_informations#update_password', as: 'update_password'
      get 'edit_password', to: 'basic_informations#edit_password', as: 'edit_password'
    end
  end

  get '/basic_informations/:id/edit_user_contact', to: 'basic_informations#edit_user_contact', as: 'edit_user_contact'
  patch '/basic_informations/:id/update_user_contact', to: 'basic_informations#update_user_contact', as: 'update_user_contact'
  get '/basic_informations/:id/edit_relationship', to: 'basic_informations#edit_relationship', as: 'edit_relationship'
  patch '/basic_informations/:id/update_relationship', to: 'basic_informations#update_relationship', as: 'update_relationship'
  resources :user_contacts
  resources :student_classes
  resources :relationships
end
