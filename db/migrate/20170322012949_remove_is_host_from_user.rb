class RemoveIsHostFromUser < ActiveRecord::Migration[5.0]
  def change
    remove_column :users, :is_host, :boolean
  end
end
