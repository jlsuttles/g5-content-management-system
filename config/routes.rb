require 'resque/server'

G5ClientHub::Application.routes.draw do

  mount Resque::Server, :at => "/resque"
  
  resources :features,  only: [:index]
  resources :widgets, only: [:edit, :update]
  resources :locations, only: [:index, :show] do
    resources :site_templates, only: [:edit, :update]
    resources :pages do
      member do
        get "preview"
      end
    end
    member do
      post "deploy"
    end
  end

  root to: "locations#index"
end
