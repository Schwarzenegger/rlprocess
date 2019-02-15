class CreateActivities < ActiveRecord::Migration[5.2]
  def change
    create_table :activities do |t|
      t.references :client, index: true
      t.references :user, index: true
      t.references :master_activity, index: true
      t.integer :status, default: 1
      t.datetime :when_moved_to_progress
      t.datetime :when_moved_to_done
      t.date :deadline
      t.string :identifier

      t.timestamps
    end
  end
end
