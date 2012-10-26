G5ClientHub::Application.routes.draw do
  match 'logout' => 'sessions#destroy', :as => :logout
  match 'login' => 'sessions#new', :as => :login
  resources :sessions
  match 'user/edit' => 'users#edit', :as => :edit_current_user
  match 'signup' => 'users#new', :as => :signup
  resources :users

  resources :features
  resources :locations

  root to: "users#index"
end
