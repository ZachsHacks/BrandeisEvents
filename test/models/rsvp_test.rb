require 'test_helper'

class RsvpTest < ActiveSupport::TestCase

	def setup
		@user = users(:two)#User.create(provider: "google", uid: "zweiss", first_name: "Example", last_name: "User", email: "user@example.com", can_host: false, is_admin: false)
	end

	test "users can RSVP to an event" do
		@user.rsvps.destroy_all
		assert_difference('Rsvp.count', 1) do
			@user.rsvps.create(event_id: Event.ids.sample, choice: 1)
		end
	end

	test "users can Un-RSVP to an event" do
		@user.rsvps.destroy_all
		@user.rsvps.create(event_id: Event.ids.sample, choice: 1)
		assert_difference('Rsvp.count', -1) do
			@user.rsvps.last.destroy
		end
	end

	test "users can change from RSVP to interested" do
		@user.rsvps.destroy_all
		@user.rsvps.create(event_id: Event.ids.sample, choice: 1)
		assert_difference('@user.rsvps.select {|r| r.choice ==1}.count', -1) do
			@user.rsvps.last.choice = 2
		end
	end

	test "users can change from Interested to RSVPS" do
		@user.rsvps.destroy_all
		@user.rsvps.create(event_id: Event.ids.sample, choice: 2)
		assert_difference('@user.rsvps.select {|r| r.choice ==2}.count', -1) do
			@user.rsvps.last.choice = 1
		end
	end

end
