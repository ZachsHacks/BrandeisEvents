require 'test_helper'

class EventsControllerTest < ActionDispatch::IntegrationTest
  setup do
		@host = users(:host)#User.create(uid: "zweiss", first_name: "Example", last_name: "User", email: "user@example.com", provider: "google", can_host: true)
		@event = events(:one)
		@event.host = @host#Event.new(user_id: @host.id, name: "My Event", description: "This event is awesome. This event is awesome. This event is awesome. This event is awesome.", start: Time.now, end: Time.now)
		#@event.save
	end


  test "should get index" do
    get events_url
    assert_response :success
  end

  # test "should get new" do
  #   get new_event_url
  #   assert_response :success
  # end

  # test "should show event" do
  #   get event_url(@event)
  #   assert_response :success
  # end

  # test "should get edit" do
  #   get edit_event_url(@event)
  #   assert_response :success
  # end

  # test "should update event" do
  #   patch event_url(@event), params: { event: { user: @event.host, description: @event.description, location: @event.location, name: @event.name, price: @event.price, start: @event.start, end: @event.end} }
  #   assert_redirected_to event_url(@event)
  # end

  # test "should destroy event" do
  #   assert_difference('Event.count', -1) do
  #     delete event_url(@event)
  #   end
  #
  #   assert_redirected_to events_url
  # end
end
