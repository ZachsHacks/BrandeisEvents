class AddImageIdToEvents < ActiveRecord::Migration[5.0]
  def change
    add_column :events, :image_id, :string
  end
end
