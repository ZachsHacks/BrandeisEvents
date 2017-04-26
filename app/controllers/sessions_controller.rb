class SessionsController < ApplicationController
	skip_before_action :store_location

	def create
		begin
			google_hash = request.env['omniauth.auth']
			new_user = User.find_by(email: google_hash["info"]["email"]).nil?
			@user = User.from_omniauth(google_hash)
			session[:user_id] = @user.id
			flash[:success] = "Welcome, #{@user.name}!"
			if new_user
				redirect_to new_account_path(@user.id)
			else
				redirect_back_or @user
			end
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
