class AuthenticationsController < Devise::OmniauthCallbacksController
    skip_before_action :verify_authenticity_token

    def saml
        begin
            hash = request.env['omniauth.auth']
            puts 'Attributes:\n\n\n'
            puts hash.attributes if hash.attributes
            puts '\n\n\nRaw info:\n\n\n'
            puts hash.raw_info if hash.raw_info
            # byebug
            # puts "Email =  #{hash.attributes['urn:oid:0.9.2342.19200300.100.1.3']}"
            # puts "UID =  #{hash.attributes['urn:oid:0.9.2342.19200300.100.1.1']}"
            # puts "First name =  #{hash.attributes['urn:oid:2.5.4.42']}"
            # puts "Last name =  #{hash.attributes['urn:oid:2.5.4.4']}"
            # redirect_to root_path
        #   @user = User.from_omniauth(request.env['omniauth.auth'])
        #   session[:user_id] = @user.id
        #   flash[:success] = "Welcome, #{@user.name}!"
        #   redirect_back_or @user
        rescue
          flash[:warning] = 'There was an error while trying to authenticate you...'
          puts 'You\'re screwed...'
          redirect_to root_path
        end
    end

end
