class CreateJoinTableClientsActivityProfiles < ActiveRecord::Migration[5.2]
  def change
    create_join_table :clients, :activity_profiles do |t|
      t.index [:client_id, :activity_profile_id], name: "client_and_profile_index"
    end
  end
end
