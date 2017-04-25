class AddRecommendationsToUsers < ActiveRecord::Migration[5.0]
  def change
      add_column :users, :recommendations, :integer, array: true, default: []
  end
end
