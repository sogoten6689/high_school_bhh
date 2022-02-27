Rails.application.routes.draw do
  root 'welcome#index'
  get '/home', to: 'home#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
    devise_for :users
    resources :basic_informations
end
