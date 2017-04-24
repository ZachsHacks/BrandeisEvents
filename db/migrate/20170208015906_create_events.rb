class CreateEvents < ActiveRecord::Migration[5.0]
  def change
    create_table :events do |t|
      t.string :name
      t.text :description
      t.string :location
      t.datetime :start
      t.datetime :end
      t.integer :price
      t.integer :host_id

      t.timestamps
    end
  end
end
