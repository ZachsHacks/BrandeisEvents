class AddViewRsvpsToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :view_rspv, :boolean
  end
end
