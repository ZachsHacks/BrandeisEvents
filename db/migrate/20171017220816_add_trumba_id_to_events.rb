class AddTrumbaIdToEvents < ActiveRecord::Migration[5.0]
  def change
      add_column :events, :trumba_id, :integer
  end
end
