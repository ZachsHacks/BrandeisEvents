class AddViewRsvpsToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :view_rsvp, :boolean
  end
end
