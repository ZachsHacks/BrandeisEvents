Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
    get 'sessions/new'

    resources :event_tags
    resources :tags
    resources :interests
    resources :rsvps
    resources :events
    resources :users
    get '/', to: 'events#home'
    get '/events/new', to: 'event#new'
    #get '/signup', to: 'users#new'
    get '/login', to: 'sessions#create'
    get '/auth/:provider/callback', to: 'sessions#create'
    #post   '/login',   to: 'sessions#create'
    get '/logout',  to: 'sessions#destroy'
		get '/search', to: 'events#search'
    # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
    get '/recommendations', to: 'events#recommendations'
    root 'events#home'
end
