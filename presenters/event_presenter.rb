require 'byebug'

class EventPresenter

	def initialize(event)
		@event = event
	end

	def get_tags_for_event
		tags = @event.tags.all
		tags.each do |t|
			p t
		end
	end

end
