class AddHash < ActiveRecord::Migration[5.0]
  def change
      add_column :users, :hash, :string
  end
end
