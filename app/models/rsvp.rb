require 'twilio-ruby'
class Rsvp < ApplicationRecord
	belongs_to :user
	belongs_to :event
	validates :user_id, :uniqueness => { :scope => :event_id}
  skip_before_action :verify_authenticity_token

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
	    @twilio_number = '+17812096211'
	    @client = Twilio::REST::Client.new ENV['TWILLIO_ACCOUNT'], ENV['TWILLIO_SECRET']
	    time_str = ((self.time).localtime).strftime("%I:%M%p on %b. %d, %Y")
	     reminder = "Hi #{self.event_id}. Just a reminder that you have an Event coming up in 30 minutes at #{time_str}."
	     message = @client.account.messages.create(
	       :from => @twilio_number,
	       :to => '+12155958832',
	       :body => reminder,
	     )
	     puts message.to
	   end

	    handle_asynchronously :reminder, :run_at => Proc.new { 1.minutes.from_now}

end
