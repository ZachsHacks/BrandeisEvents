class AuthenticationsController < Devise::OmniauthCallbacksController
    skip_before_action :verify_authenticity_token

    def saml
        begin
            hash = request.env['omniauth.auth']
          @user = User.from_omniauth(hash)
          session[:user_id] = @user.id
          flash[:success] = "Welcome, #{@user.name}!"
          redirect_back_or @user
        rescue
          flash[:warning] = 'There was an error while trying to authenticate you...'
          puts 'You\'re screwed...'
          redirect_to root_path
        end
    end

end
