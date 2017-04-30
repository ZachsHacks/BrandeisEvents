class AuthenticationsController < Devise::OmniauthCallbacksController
    skip_before_action :verify_authenticity_token

    def saml
        puts '😃 We made it!'
    end

end
