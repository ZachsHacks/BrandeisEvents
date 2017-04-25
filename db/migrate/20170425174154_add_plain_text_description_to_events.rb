class AddPlainTextDescriptionToEvents < ActiveRecord::Migration[5.0]
  def change
    add_column :events, :description_text, :string
  end
end
