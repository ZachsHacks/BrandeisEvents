class AddCanHostToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :can_host, :boolean
  end
end
