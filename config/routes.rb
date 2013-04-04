require 'resque/server'

G5ClientHub::Application.routes.draw do

  mount Resque::Server, :at => "/resque"

  resources :widgets, only: [:edit, :update]
  resources :widget_entries, only: [:index, :show]
  resources :tags, only: [:show]

  resources :locations, only: [:index, :show] do
    resources :site_templates, only: [:edit, :update]
    resources :pages do
      member do
        get "preview"
        put "toggle_disabled"
      end
    end
    member do
      post "deploy"
    end
  end

  root to: "locations#index"
end
