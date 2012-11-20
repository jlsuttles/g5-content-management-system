require 'resque/server'

G5ClientHub::Application.routes.draw do
  mount Resque::Server, :at => "/resque"

  resources :features, only: [:index]
  resources :locations, only: [:index] do
    member do
      post "deploy"
    end
  end

  root to: "locations#index"
end
