class AddTrumbaIdToRsvps < ActiveRecord::Migration[5.0]
  def change
      add_column :rsvps, :trumba_id, :integer
  end
end
