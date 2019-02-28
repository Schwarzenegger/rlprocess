class RenameActivityCheckTable < ActiveRecord::Migration[5.2]
  def change
    rename_table :activiy_check_lists, :activity_check_lists
  end
end
