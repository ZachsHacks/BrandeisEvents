require 'test_helper'

class EventTest < ActiveSupport::TestCase

	def setup
		@manual = true
		@host = users(:host)
		@guest = users(:two)
		@event = events(:one)
		@event.user_id = @host.id
	end

	test "should be valid event" do
		assert @event.valid?
	end

	test "name should be present" do
		@event.name = ""
		assert_not @event.valid?
	end

	test "description should be present" do
		@event.description = "     "
		assert_not @event.valid?
	end


	test "events is associated with users through rsvps" do
		assert 0, @event.rsvps.count
	end

end
