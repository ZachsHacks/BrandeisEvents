class UserMailer < ApplicationMailer

    default from: 'info@brandeisevents.com'

    def reminder(user, event)
        @user = user
        @event = event
        mail(to: @user.email, subject: "REMINDER: #{@event.name}", from: 'info@brandeisevents.com').deliver!
    end

    def survey(user)
        @user = user
        mail(to: @user.email, subject: 'BrandeisEvents Survey!', from: 'info@brandeisevents.com').deliver!
    end

end
