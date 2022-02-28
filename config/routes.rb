Rails.application.routes.draw do
  root 'home#index'
  get '/home', to: 'home#index'
  get '/contact', to: 'home#contact'
  devise_for :users
  resources :basic_informations
end
