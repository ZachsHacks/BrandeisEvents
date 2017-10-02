class UserMailer < ApplicationMailer

    default from: 'brandeisevents@gmail.com'

    def survey(user)
        @user = user
        mail(to: @user.email, subject: 'BrandeisEvents Survey!').deliver!
    end

end
