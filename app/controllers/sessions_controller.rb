class SessionsController < ApplicationController
	skip_before_action :store_location


  def create
    begin
	  hash = request.env['omniauth.auth']
	  if Rails.env.development?
      	@user = User.from_google(hash)
	  else
		@user = User.from_saml(hash)
	  end
      session[:user_id] = @user.id
      flash[:success] = "Welcome, #{@user.name}!"
      redirect_back_or @user
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
