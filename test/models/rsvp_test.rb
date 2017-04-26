require 'test_helper'

class RsvpTest < ActiveSupport::TestCase

	def setup
		@user = users(:two)#User.create(provider: "google", uid: "zweiss", first_name: "Example", last_name: "User", email: "user@example.com", can_host: false, is_admin: false)
	end

	test "users can RSVP to an event" do
		@user.rsvps.destroy_all
		assert_difference('Rsvp.count', 1) do
			# byebug
			@user.rsvps.create(event_id: Event.ids.sample, choice: 1)
		end
	end

end
