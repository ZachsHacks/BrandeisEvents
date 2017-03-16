require 'test_helper'

class RsvpTest < ActiveSupport::TestCase

	def setup
		@user = User.create(provider: "google", uid: "zweiss", first_name: "Example", last_name: "User", email: "user@example.com", is_host: false)
	end

	test "users are associated with rsvps" do
		assert_difference('Rsvp.count', 1) do
			@user.rsvps.create(event_id: 2, choice: 1)
		end
	end

end
