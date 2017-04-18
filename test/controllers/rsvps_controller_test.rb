require 'test_helper'

class RsvpsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @rsvp = Rsvp.new(user_id: User.ids.sample, event_id: Event.ids.sample)
  end


#   test "should create rsvp" do
#     assert_difference('Rsvp.count') do
# 		  post rsvps_url, params: { rsvp: { choice: @rsvp.choice, event_id: @rsvp.event_id, user_id: @rsvp.user_id } }
#     end
#     assert_redirected_to rsvp_url(Rsvp.last)
#   end
#
#
#   test "should destroy rsvp" do
#     assert_difference('Rsvp.count', -1) do
#       delete rsvp_url(@rsvp)
#     end
#
#     assert_redirected_to rsvp_url
#   end
end
