class AddNotificationTimesToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :email_time_num, :integer, default: 0
    add_column :users, :email_time_unit, :string, default: 'days'
    add_column :users, :text_time_num, :integer, default: 30
    add_column :users, :text_time_unit, :string, default: 'minutes'
  end
end
