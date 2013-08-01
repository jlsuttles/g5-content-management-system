require 'resque/server'

G5ClientHub::Application.routes.draw do
  mount Resque::Server, :at => "/resque"

  root to: "locations#index"

  resources :locations, only: [:index]
  resources :websites, only: [:show] do
    member do
      post "deploy"
    end
  end
  resources :web_template, only: [:show]
  resources :widgets, only: [:edit, :update]
  resources :settings, only: [:index]

  resources :widget_entries, only: [:index, :show]
  resources :tags, only: [:show]

  get "ember", to: "ember#start"

  namespace :api do
    namespace :v1 do
      resources :locations, only: [:show]
      resources :websites, only: [:show, :update]

      resources :website_templates, only: [:show]
      resources :web_layouts, only: [:show, :update]
      resources :web_themes, only: [:show, :update]
      resources :logo_widgets, only: [:index, :show, :create, :destroy]
      resources :phone_widgets, only: [:index, :show, :create, :destroy]
      resources :btn_widgets, only: [:index, :show, :create, :destroy]
      resources :nav_widgets, only: [:index, :show, :create, :destroy]
      resources :aside_widgets, only: [:index, :show, :create, :destroy]
      resources :footer_widgets, only: [:index, :show, :create, :destroy]

      resources :web_home_templates, only: [:show]
      resources :web_page_templates, only: [:show]
      resources :main_widgets, only: [:index, :show, :create, :destroy]

      resources :remote_web_layouts, only: [:index]
      resources :remote_web_themes, only: [:index]
      resources :remote_widgets, only: [:index]
    end
  end
end
