G5ClientHub::Application.routes.draw do
  resources :features

  resources :locations

  match 'client/edit' => 'clients#edit', :as => :edit_current_client

  match 'signup' => 'clients#new', :as => :signup

  match 'logout' => 'sessions#destroy', :as => :logout

  match 'login' => 'sessions#new', :as => :login

  resources :sessions

  resources :clients

  root to: "sessions#new"
end
