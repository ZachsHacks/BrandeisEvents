class SessionsController < ApplicationController
  skip_before_action :store_location

  def login_local
	session[:user_id] = params["user_id"]
	@user = User.find(params["user_id"])
	redirect_back_or @user
  end

  def create
    begin
      redirect_to root_path
    rescue
      flash[:warning] = 'There was an error while trying to authenticate you...'
      redirect_to root_path
    end
  end

  def destroy
    if current_user
      session.delete(:user_id)
      flash[:success] = 'See you!'
    end
    redirect_back_or root_path
  end
end
