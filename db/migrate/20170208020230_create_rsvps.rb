class CreateRsvps < ActiveRecord::Migration[5.0]
  def change
    create_table :rsvps do |t|
      t.integer :user_id
      t.integer :event_id
      t.integer :choice

      t.timestamps
    end
  end
end
