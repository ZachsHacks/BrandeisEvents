Rails.application.routes.draw do
  get 'errors/not_found'

  get 'errors/internal_server_error'

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  get 'sessions/new'
	get '/login/:user_id' => 'sessions#login_local' if Rails.env.development?
  get '/users/:id/creation_form' => 'users#creation_form'
  get '/users/auth/:provider/callback', to: 'sessions#create'
  resources :event_tags
  resources :interests
  resources :events
  resources :users, :except => :index
  devise_for :users, :controllers => { :omniauth_callbacks => "authentications"}
  devise_scope :user do
    get 'sign_in', :to => 'devise/sessions#new', :as => :new_user_session
    get 'sign_out', :to => 'devise/sessions#destroy', :as => :destroy_user_session
  end
  get '/', to: 'events#home'
  get '/events/new', to: 'events#new'
  get '/events/new/trumba', to: 'events#new_trumba'
  get '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'
  get '/search', to: 'events#search', as: 'search'
  post '/get_events', to: 'users#get_events', as: 'get_events'
  get 'users/:id/new_account', to: 'users#creation_form', as: 'new_account'
  get '/top_events_json', to: 'events#top_events', :defaults => { :format => :json }
  get '/top_events_on_day/:date', to: 'events#top_events_on_day', :defaults => { :format => :json }


  get 'users/:calendar_hash/calendar-sync', to: 'users#to_icalendar'


  match '/404', :to => "errors#not_found", :via => :all
  match "/500", :to => "errors#internal_server_error", :via => :all
  post '/rsvp', to: 'rsvps#rsvp', as: 'rsvp'
  post '/add_interest', to: 'interests#add_interest', as: 'add_interest'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'events#home'
end
