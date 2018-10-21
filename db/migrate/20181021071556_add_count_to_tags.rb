class AddCountToTags < ActiveRecord::Migration[5.0]
  def change
      add_column :tags, :event_count, :integer
  end
end
