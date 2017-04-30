class AuthenticationsController < Devise::OmniauthCallbacksController
    skip_before_action :verify_authenticity_token

    def saml
        puts '😃 We made it!'
        begin
            puts request.env['omniauth.auth']
            # redirect_to root_path
        #   @user = User.from_omniauth(request.env['omniauth.auth'])
        #   session[:user_id] = @user.id
        #   flash[:success] = "Welcome, #{@user.name}!"
        #   redirect_back_or @user
        rescue
          flash[:warning] = 'There was an error while trying to authenticate you...'
          redirect_to root_path
        end
    end

end
