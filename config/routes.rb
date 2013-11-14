require 'resque/server'

G5ClientHub::Application.routes.draw do
  mount Resque::Server, :at => "/resque"

  root to: "locations#index"

  get '/website/:id/', to: 'locations#index'
  get '/location/:id/home/:id', to: 'locations#index'
  get '/location/:id/page/:id', to: 'locations#index'

  resources :locations, only: [:index]
  resources :websites, only: [] do
    member do
      post "deploy"
    end
  end
  resources :web_templates, only: [:show]
  resources :widgets, only: [:edit, :update]
  resources :settings, only: [:index]

  resources :widget_entries, only: [:index, :show]
  resources :tags, only: [:show]

  namespace :api do
    namespace :v1 do
      resources :clients, only: [:show]
      resources :locations, only: [:index, :show]
      resources :websites, only: [:show, :update]

      resources :website_templates, only: [:show]
      resources :web_layouts, only: [:show, :update]
      resources :web_themes, only: [:show, :update]
      resources :head_widgets, only: [:index, :show, :create, :destroy]
      resources :logo_widgets, only: [:index, :show, :create, :destroy]
      resources :phone_widgets, only: [:index, :show, :create, :destroy]
      resources :btn_widgets, only: [:index, :show, :create, :destroy]
      resources :nav_widgets, only: [:index, :show, :create, :destroy]
      resources :aside_widgets, only: [:index, :show, :create, :update, :destroy]
      resources :footer_widgets, only: [:index, :show, :create, :destroy]

      resources :web_home_templates, only: [:show, :update]
      resources :web_page_templates, only: [:show, :create, :update]
      resources :main_widgets, only: [:index, :show, :create, :update, :destroy]

      resources :remote_web_layouts, only: [:index]
      resources :remote_web_themes, only: [:index]
      resources :remote_widgets, only: [:index]
    end
  end
end
