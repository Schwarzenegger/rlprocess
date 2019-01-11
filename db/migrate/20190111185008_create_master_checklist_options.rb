class CreateMasterChecklistOptions < ActiveRecord::Migration[5.2]
  def change
    create_table :master_checklist_options do |t|
      t.string :name
      t.references :master_activity, index: true

      t.timestamps
    end
  end
end
