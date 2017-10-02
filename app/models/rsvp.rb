require 'twilio-ruby'
class Rsvp < ApplicationRecord
  belongs_to :user
  belongs_to :event, counter_cache: :rsvps_count
  validates :user_id, :uniqueness => { :scope => :event_id}

  after_create :reminder
  after_create :survey

  @@REMINDER_TIME = 30.minutes # minutes before appointment

  def when_to_run
    Event.find(self.event_id).start - @@REMINDER_TIME
  end

  # Notify our appointment attendee X minutes before the appointment time

  def reminder
    user_id = self.user_id
    if !user_id.nil? && User.find(user_id).phone
      @twilio_number = ENV['TWILLIO_NUMBER']
      @client = Twilio::REST::Client.new ENV['TWILLIO_ACCOUNT'], ENV['TWILLIO_SECRET']
      # time_str = ((self.event_id).localtime).strftime("%I:%M%p on %b. %d, %Y")
      event_id = self.event_id
      user_id = self.user_id
      @e = Event.find(event_id)
      @user = User.find(user_id)
      start_time = @e.start.in_time_zone().strftime("%I:%M%p on %b. %d, %Y")
      event_name = @e.name
      reminder = "Hi #{@user.first_name}. Just a reminder that you have an event (#{event_name}) coming up in 30 minutes at #{start_time}. The event can be viewed at BrandeisEvents.com/events/#{event_id}."
      message = @client.api.account.messages.create(
        :from => @twilio_number,
        :to => @user.phone,
        :body => reminder,
      )
      puts message.to
    end
  end



  def survey
    user_id = self.user_id
    if !user_id.nil? && User.find(self.user_id).rsvps.count > 4
      @twilio_number = ENV['TWILLIO_NUMBER']
      @client = Twilio::REST::Client.new(ENV['TWILLIO_ACCOUNT'], ENV['TWILLIO_SECRET'])
      @user = User.find(self.user_id)

      if  !@user.survey_sent
		@user.survey_sent = true
		@user.save
        if User.find(user_id).phone
            reminder_survey = "Thanks for using BrandeisEvents! Now that you've RSVP'D to 5 events, you are eligible to win a $25 Amazon gift card. Enter at: http://bit.ly/2xEWEsL"
            message_survey = @client.api.account.messages.create(
                :from => @twilio_number,
                :to => @user.phone,
                :body => reminder_survey,
            )
            puts message_survey.to
        end
        UserMailer.survey(@user)
      end
    end
  end


  handle_asynchronously :reminder, :run_at => Proc.new { |i| i.when_to_run}
  handle_asynchronously :survey, :run_at => 1.minutes.from_now

end
