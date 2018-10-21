class AddTopTagsToEvents < ActiveRecord::Migration[5.0]
  def change
      add_column :events, :top_tags, :string
  end
end
