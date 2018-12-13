class CreateMasterActivities < ActiveRecord::Migration[5.2]
  def change
    create_table :master_activities do |t|
      t.string :name
      t.integer :category
      t.integer :frequency
      t.integer :deadline_year
      t.string :deadline_month, array: true
      t.integer :deadline_day

      t.boolean :has_checkbox
      t.string :checkbox_options, array: true
      
      t.timestamps
    end
  end
end
