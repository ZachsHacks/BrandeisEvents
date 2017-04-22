class AddAvatarToFriends < ActiveRecord::Migration[5.0]
  def change
    add_attachment :events, :event_image
  end
end
