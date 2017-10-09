class UserMailer < ApplicationMailer

    default from: 'info@brandeisevents.com'

    def reminder(user, event)
        @user = user
        @event = event
        send_mail("REMINDER: #{@event.name}")
    end

    def survey(user)
        @user = user
        send_mail('BrandeisEvents Survey!')
    end

    def received_survey_reminder(user)
        @user = user
        send_mail('BrandeisEvents Survey!')
    end

    def not_received_survey_reminder(user)
        @user = user
        send_mail('Welcome to BrandeisEvents!')
    end

    def send_mail(subject)
        mail(to: @user.email, subject: subject, from: 'info@brandeisevents.com').deliver!
    end


      def survey_reminders
        User.all.each { |u|
            if(u.survey_sent)
                UserMailer.received_survey_reminder(u).deliver! unless (ENV['RESPONDENTS'].split("\n").include? u.email)
            else
                UserMailer.not_received_survey_reminder(u).deliver! unless ENV['SURVEY_SPAM_OVERRIDE'].split("\n").include? u.email
            end
        }
      end

end
