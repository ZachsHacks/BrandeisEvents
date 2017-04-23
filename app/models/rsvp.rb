require 'twilio-ruby'
class Rsvp < ApplicationRecord
	belongs_to :user
	belongs_to :event
	validates :user_id, :uniqueness => { :scope => :event_id}

	 after_create :reminder
		#
		#
	  # @@REMINDER_TIME = 30.minutes # minutes before appointment
		#
	  # def when_to_run
	  #   time - @@REMINDER_TIME
	  # end

	  # Notify our appointment attendee X minutes before the appointment time

	  def reminder
				user_id = self.user_id
			if !user_id.nil?
	    @twilio_number = ENV['TWILLIO_NUMBER']
	    @client = Twilio::REST::Client.new ENV['TWILLIO_ACCOUNT'], ENV['TWILLIO_SECRET']
	    # time_str = ((self.event_id).localtime).strftime("%I:%M%p on %b. %d, %Y")
			event_id = self.event_id
			user_id = self.user_id
			@e = Event.find(event_id)
			@user = User.find(user_id)
			start_time = @e.start.localtime.strftime("%I:%M%p on %b. %d, %Y")
			event_name = @e.name
	     reminder = "Hi #{@user.name}. Just a reminder that you have an Event (#{event_name}) coming up in 30 minutes at #{start_time}. The event can be viewed at campusnow.herokuapp.com/events/#{event_id}."
	     message = @client.account.messages.create(
	       :from => @twilio_number,
	       :to => @user.phone,
	       :body => reminder,
	     )
	     puts message.to
	   end
	 end

	    handle_asynchronously :reminder, :run_at => Proc.new { 1.minutes.from_now}

end
