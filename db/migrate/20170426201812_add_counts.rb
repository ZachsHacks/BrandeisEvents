class AddCounts < ActiveRecord::Migration[5.0]
  def change
      add_column :tags, :events_count, :integer, :default => 0
      add_column :events, :rsvps_count, :integer, :default => 0
  end
end
