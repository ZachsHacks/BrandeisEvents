require 'twilio-ruby'
class Rsvp < ApplicationRecord
  belongs_to :user
  belongs_to :event, counter_cache: :rsvps_count
  validates :user_id, :uniqueness => { :scope => :event_id}

  after_create :email
  after_create :text
  after_create :survey


  def when_to_email
    @user = User.find(user_id)
    Event.find(self.event_id).start - ChronicDuration.parse("#{@user.email_time_num}#{@user.email_time_unit}", :keep_zero => true).seconds
  end

  def when_to_text
    @user = User.find(user_id)
    Event.find(self.event_id).start - ChronicDuration.parse("#{@user.text_time_num}#{@user.text_time_unit}", :keep_zero => true).seconds
  end

  # Notify our appointment attendee X minutes before the appointment time

  def email
      @user = User.find(user_id)
      @event = Event.find(event_id)
      UserMailer.reminder(@user, @event).deliver! unless @user.email_time_num == 0
  end

  def text
    @user = User.find(user_id)
    @event = Event.find(event_id)
    if @user.phone && @user.email_time_num != 0
      @twilio_number = ENV['TWILLIO_NUMBER']
      @client = Twilio::REST::Client.new ENV['TWILLIO_ACCOUNT'], ENV['TWILLIO_SECRET']
      start_time = @event.start.in_time_zone().strftime("%I:%M%p on %b. %d, %Y")
      event_name = @event.name
      reminder = "Hi #{@user.first_name}. Just a reminder that you have an event (#{event_name}) coming up at #{start_time}. The event can be viewed at #{@event.url}."
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

      if !@user.survey_sent
		@user.survey_sent = true
		@user.save
        UserMailer.survey(@user).deliver!
        if User.find(user_id).phone
            reminder_survey = "Thanks for using DeisToday! You've RSVP'D to 5 events & are now eligible to win a $25 Amazon gift card. Enter at: http://bit.ly/2xEWEsL"
            message_survey = @client.api.account.messages.create(
                :from => @twilio_number,
                :to => @user.phone,
                :body => reminder_survey,
            )
            puts message_survey.to
        end
      end
    end
  end


  handle_asynchronously :email, :run_at => Proc.new { |i| i.when_to_email}
  handle_asynchronously :text, :run_at => Proc.new { |i| i.when_to_text}
  handle_asynchronously :survey, :run_at => 1.minutes.from_now

end
