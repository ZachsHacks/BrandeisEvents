require 'byebug'

class EventPresenter

	def initialize(event)
		@event = event
	end

	def create_tags(params)
		tags = [:religious, :clubs, :food, :sports, :academic]

		tags.each do |tag|
			EventTag.create(tag_id: params[tag], event_id: @event.id) if params[tag]
		end

	end

	def update_tags(params)

		tags = [:religious, :clubs, :food, :sports, :academic]

		tags.each do |tag|
			EventTag.update(name: params[tag], event_id: @event.id) if params[tag]
		end

	end

	# def display_tags
	# 	tags = @event.event_tags.all
	#
	# 	s = "Tags"
	# 	tags.each do |tag|
	# 		tag
	# 	end
	# end

end
