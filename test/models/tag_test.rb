require 'test_helper'
class TagTest < ActiveSupport::TestCase

  def setup
		@manual = true
		@host = users(:host)#User.create(uid: "zweiss1", first_name: "Example", last_name: "User", email: "user@example.com", provider: "google", can_host: true, is_admin: false)
		@guest = users(:two) #User.create(uid: "acarr", first_name: "Example1", last_name: "User1", email: "user1@example.com", provider: "google", can_host: false, is_admin: false)
		@event = events(:one)#Event.new(user_id: @host.id, name: "My Event", description: "This event is awesome. This event is awesome. This event is awesome. This event is awesome.")
		@event.user_id = @host.id
	end


  test "Can add tag to an event" do
    assert_difference('@event.tags.count', 1) do
      @event.tags.create(name: "politics")
    end
  end

  test "Can delete tag to an event" do
      @event.tags.create(name: "politics")
    assert_difference('@event.tags.count', -1) do
  
      @event.tags.last.destroy
    end
  end

end
