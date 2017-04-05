class ApplicationController < ActionController::Base
  helper :all
  protect_from_forgery with: :exception
  include SessionsHelper
  before_action :store_location
  include CanCan::ControllerAdditions

  private

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  helper_method :current_user
end
