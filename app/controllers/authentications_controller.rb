class AuthenticationsController < Devise::OmniauthCallbacksController

    def saml
        puts '😃 We made it!'
        redirect_to root_path
    end

end
