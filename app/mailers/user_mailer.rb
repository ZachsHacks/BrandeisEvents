class UserMailer < ApplicationMailer

    default from: 'info@brandeisevents.com'

    def reminder(user, event)
        @user = user
        @event = event
        send_mail("REMINDER: #{@event.name}")
    end

    def survey(user)
        @user = user
        send_mail('DeisToday Survey!')
    end

    def received_survey_reminder(user)
        @user = user
        send_mail('DeisToday Survey!')
    end

    def not_received_survey_reminder(user)
        @user = user
        send_mail('Welcome to DeisToday!')
    end

    def send_mail(subject)
        mail(to: @user.email, subject: subject, from: 'info@brandeisevents.com').deliver!
    end


      def survey_reminders
        User.select{ |u| !(ENV['ALREADY_SENT'].split("\n").include? u.uid)}.each { |u|
            if(u.survey_sent)
                UserMailer.received_survey_reminder(u).deliver! unless (ENV['RESPONDENTS'].split("\n").map {|s| s.downcase}.include? u.email)
            else
                UserMailer.not_received_survey_reminder(u).deliver! unless ENV['SURVEY_SPAM_OVERRIDE'].split("\n").include? u.email
            end
        }
      end

end
