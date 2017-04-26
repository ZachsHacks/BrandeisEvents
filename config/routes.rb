Rails.application.routes.draw do
  get 'errors/not_found'

  get 'errors/internal_server_error'

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  get 'sessions/new'
  get '/users/:id/creation_form' => 'users#creation_form'
  resources :event_tags
  resources :interests
  resources :events
  resources :users, :except => :index
  get '/', to: 'events#home'
  get '/events/new', to: 'events#new'
  get '/login', to: 'sessions#create'
  get '/auth/:provider/callback', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'
  get '/search', to: 'events#search'
  post '/get_events', to: 'users#get_events', as: 'get_events'
  get 'users/:id/new_account', to: 'users#creation_form', as: 'new_account'
  get '/top_events_json', to: 'events#top_events', :defaults => { :format => :json }

  match "/404", :to => "errors#not_found", :via => :all
  match "/500", :to => "errors#internal_server_error", :via => :all
  post '/rsvp', to: 'rsvps#rsvp', as: 'rsvp'
  post '/add_interest', to: 'interests#add_interest', as: 'add_interest'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'events#home'
end
