Rails.application.routes.draw do
    get 'sessions/new'

    resources :event_tags
    resources :tags
    resources :interests
    resources :rsvps
    resources :users
    resources :events
    get '/', to: 'welcome#index'
    get '/events/new', to: 'event#new'
    get '/signup', to: 'users#new'
    get '/login', to: 'sessions#new'
    post   '/login',   to: 'sessions#create'
    delete '/logout',  to: 'sessions#destroy'
    # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
    root 'welcome#index'
end
