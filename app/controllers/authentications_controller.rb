class AuthenticationsController < Devise::OmniauthCallbacksController
    skip_before_action :verify_authenticity_token

    #    def saml
    #        begin
    #          hash = request.env['omniauth.auth']
    #          @user = User.from_omniauth(hash)
    #          session[:user_id] = @user.id
    #          flash[:success] = "Welcome, #{@user.name}!"
    #          if(@user.new_record?)
    # +			redirect_to new_account_path(@user.id)
    # +		  else
    # +			redirect_back_or @user
    # +		  end
    #        rescue
    #          flash[:warning] = 'There was an error while trying to authenticate you...'
    #          puts 'You\'re screwed...'
    #          redirect_to root_path
    #        end
    #    end

    def saml
        hash = request.env['omniauth.auth']
        new_user = User.find_by(uid: hash['urn:oid:0.9.2342.19200300.100.1.1'][0]).nil?
        @user = User.from_omniauth(hash)
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
