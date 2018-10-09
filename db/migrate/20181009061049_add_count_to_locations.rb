class AddCountToLocations < ActiveRecord::Migration[5.0]
  def change
      add_column :locations, :event_count, :integer
  end
end
