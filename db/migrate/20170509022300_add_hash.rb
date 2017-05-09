class AddHash < ActiveRecord::Migration[5.0]
  def change
      add_column :users, :uid_hash, :string
  end
end
