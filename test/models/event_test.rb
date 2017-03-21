require 'test_helper'

class EventTest < ActiveSupport::TestCase

	def setup
		@host = User.create(uid: "zweiss", first_name: "Example", last_name: "User", email: "user@example.com", is_host: true, provider: "google")
		@guest = User.create(uid: "acarr", first_name: "Example1", last_name: "User1", email: "user1@example.com", is_host: false, provider: "google")
		@event = Event.new(user_id: @host.id, name: "My Event", description: "This event is awesome")
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
		@event.save
		@event.rsvps.create(user_id: @guest.id, choice: 2)
		assert_equal 1, @event.rsvps.count
	end

	# test "events belong to host" do
	# 	it { should belong_to(:user) }
	# end
	#
	# test "events have attendees through RSVPs" do
	#
	# end
	#
	# test "events have attendees" do
	#
	# end

end
