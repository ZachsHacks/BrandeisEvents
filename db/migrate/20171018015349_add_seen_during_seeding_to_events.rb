class AddSeenDuringSeedingToEvents < ActiveRecord::Migration[5.0]
  def change
    add_column :events, :seen_during_seeding, :boolean
  end
end
