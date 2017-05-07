class AddPhoneToUsers2 < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :phone, :string
  end
end
