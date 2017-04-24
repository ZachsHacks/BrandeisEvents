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
  # get '/events/new', to: 'event#new'
  get '/login', to: 'sessions#create'
  get '/auth/:provider/callback', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'
  get '/search', to: 'events#search'
  post '/get_events', to: 'users#get_events', as: 'get_events'
<<<<<<< HEAD
  get 'users/:id/new_account', to: 'users#creation_form', as: 'new_account'
=======
  match "/404", :to => "errors#not_found", :via => :all
  match "/500", :to => "errors#internal_server_error", :via => :all
>>>>>>> 7f77ddb5d1ca73f16451a379a4593110c9d0d624

  post '/rsvp', to: 'rsvps#rsvp', as: 'rsvp'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'events#home'
end
