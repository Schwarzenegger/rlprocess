class AlterDeadlineYearFromMasterActivity < ActiveRecord::Migration[5.2]
  def change
    remove_column :master_activities, :deadline_year, :integer
    add_column :master_activities, :deadline_date, :date
  end
end
