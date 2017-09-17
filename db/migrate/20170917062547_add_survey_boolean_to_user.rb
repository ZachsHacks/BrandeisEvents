class AddSurveyBooleanToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :survey_sent, :boolean
  end
end
