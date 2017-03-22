require 'test_helper'

class RsvpTest < ActiveSupport::TestCase

	def setup
		@user = User.create(provider: "google", uid: "zweiss", first_name: "Example", last_name: "User", email: "user@example.com", can_host: false, is_admin: false)
	end

	test "users are associated with rsvps" do
		assert_difference('Rsvp.count', 1) do
			@user.rsvps.create(event_id: Event.ids.sample, choice: 1)
		end
	end

end
