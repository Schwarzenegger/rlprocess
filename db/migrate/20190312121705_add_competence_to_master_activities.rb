class AddCompetenceToMasterActivities < ActiveRecord::Migration[5.2]
  def change
    add_column :master_activities, :competence, :integer
    add_column :master_activities, :start_date, :date
  end
end
