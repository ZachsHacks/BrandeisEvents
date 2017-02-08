class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :password_hash
      t.string :email
      t.text :bio
      t.boolean :is_host

      t.timestamps
    end
    add_index :users, :email, unique: true
  end
end
