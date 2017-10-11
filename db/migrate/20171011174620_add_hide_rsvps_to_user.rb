class AddHideRsvpsToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :hide_rsvp, :boolean
  end
end
