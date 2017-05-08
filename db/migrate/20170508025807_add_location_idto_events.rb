class AddLocationIdtoEvents < ActiveRecord::Migration[5.0]
  def change
		add_column :events, :location_id, :integer
  end
end
