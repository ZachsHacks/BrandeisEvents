require 'test_helper'

class EventTest < ActiveSupport::TestCase

	def setup
		@manual = true
		@host = users(:host)#User.create(uid: "zweiss1", first_name: "Example", last_name: "User", email: "user@example.com", provider: "google", can_host: true, is_admin: false)
		@guest = users(:two) #User.create(uid: "acarr", first_name: "Example1", last_name: "User1", email: "user1@example.com", provider: "google", can_host: false, is_admin: false)

		@event = Event.new(user_id: @host.id, name: "My Event", description: "This event is awesome. This event is awesome. This event is awesome. This event is awesome.")
		@event.user_id = @host.id
	end

	test "should be valid event" do
		assert @event.valid?
	end

	test "name should be present" do
		@event.name = ""
		assert_not @event.valid?
	end
	#
	# test "description should be present" do
	# 	@event.description = "     "
	# 	assert_not @event.valid?
	# end


	test "events is associated with users through rsvps" do
		assert 0, @event.rsvps.count
	end

end
