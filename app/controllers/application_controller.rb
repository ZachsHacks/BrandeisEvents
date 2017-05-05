class ApplicationController < ActionController::Base
  helper :all
  protect_from_forgery with: :exception
  include SessionsHelper
  before_action :store_location, :grab_all_locations, :current_user, :current_user_location
  include CanCan::ControllerAdditions



  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end
  def current_user_location
      @lat_lng = cookies[:lat_lng]

  end

  private
	def grab_all_locations
		@all_locations = Location.all.pluck(:name)
	end

  helper_method :current_user
end
