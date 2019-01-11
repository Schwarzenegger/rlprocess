class RemoveChecklistOptionsFromMasterActivity < ActiveRecord::Migration[5.2]
  def change
    remove_column :master_activities, :has_checkbox
    remove_column :master_activities, :checkbox_options
  end
end
