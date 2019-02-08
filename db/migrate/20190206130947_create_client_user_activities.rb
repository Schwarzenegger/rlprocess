class CreateClientUserActivities < ActiveRecord::Migration[5.2]
  def change
    create_table :client_user_activities do |t|
      t.references :client, index: true
      t.references :user, index: true
      t.references :master_activity, index: true

      t.timestamps
    end
  end
end
