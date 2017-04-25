class ApplicationController < ActionController::Base
  helper :all
  protect_from_forgery with: :exception
  include SessionsHelper
  before_action :store_location, :grab_all_locations, :current_user
  include CanCan::ControllerAdditions

  private

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
    
  end

	def grab_all_locations
		@all_locations = Location.all.pluck(:name)
	end

  helper_method :current_user
end
