class AddImageToTags < ActiveRecord::Migration[5.0]
  def change
    add_column :tags, :image, :string
  end
end
