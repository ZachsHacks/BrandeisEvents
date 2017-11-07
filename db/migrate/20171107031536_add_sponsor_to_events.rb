class AddSponsorToEvents < ActiveRecord::Migration[5.0]
  def change
		add_column :events, :sponsor, :string
  end
end
