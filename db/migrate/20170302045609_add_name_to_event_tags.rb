class AddNameToEventTags < ActiveRecord::Migration[5.0]
  def change
		add_column :event_tags, :name, :string
  end
end
