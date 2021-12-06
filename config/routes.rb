Rails.application.routes.draw do
  resources :rooms
  resources :openingtimes
  resources :buildings

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  # '/users/...'
  # https://github.com/plataformatec/devise#configuring-routes
  devise_for :users, path: 'users',
    controllers: {
      registrations: 'users/registrations',
      omniauth_callbacks: 'users/omniauth_callbacks'
    }
  resources :users, only: [:show]
  # '/protected'
  get '/protected', to: 'welcome#protected'

  get '/building_map', to: 'building_map#index'

  # '/search_results'
  get '/search_results', to: 'search_results#index'
  
  # (indoor) map
  get 'map', to: 'map#index'

  # '/'
  # Sets `root_url`, devise gem requires this to be set
  root to: "welcome#index"
end
