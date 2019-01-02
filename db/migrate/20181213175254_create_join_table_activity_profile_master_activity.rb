class CreateJoinTableActivityProfileMasterActivity < ActiveRecord::Migration[5.2]
  def change
    create_join_table :activity_profiles, :master_activities do |t|
       t.index [:activity_profile_id, :master_activity_id], name: "activity_and_profiles_index"
    end
  end
end
