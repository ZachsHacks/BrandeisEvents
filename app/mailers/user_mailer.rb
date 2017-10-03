class UserMailer < ApplicationMailer

    default from: 'info@brandeisevents.com'

    def survey(user)
        @user = user
        mail(to: @user.email, subject: 'BrandeisEvents Survey!', from: 'info@brandeisevents.com').deliver!
    end

end
