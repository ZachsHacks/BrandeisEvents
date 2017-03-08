require 'test_helper'

class EventTest < ActiveSupport::TestCase
	
	def setup
		@event = Event.new(name: "My Event", description: "This event is awesome")
	end

	test "should be valid" do
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

end
