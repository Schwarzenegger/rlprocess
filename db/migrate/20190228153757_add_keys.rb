class AddKeys < ActiveRecord::Migration[5.2]
  def change
    add_foreign_key "activities", "clients", name: "activities_client_id_fk"
    add_foreign_key "activities", "master_activities", name: "activities_master_activity_id_fk"
    add_foreign_key "activities", "users", name: "activities_user_id_fk"
    add_foreign_key "activity_check_lists", "activities", name: "activity_check_lists_activity_id_fk"
    add_foreign_key "activity_profiles_clients", "activity_profiles", name: "activity_profiles_clients_activity_profile_id_fk"
    add_foreign_key "activity_profiles_clients", "clients", name: "activity_profiles_clients_client_id_fk"
    add_foreign_key "activity_profiles_master_activities", "activity_profiles", name: "activity_profiles_master_activities_activity_profile_id_fk"
    add_foreign_key "activity_profiles_master_activities", "master_activities", name: "activity_profiles_master_activities_master_activity_id_fk"
    add_foreign_key "client_user_activities", "clients", name: "client_user_activities_client_id_fk"
    add_foreign_key "client_user_activities", "master_activities", name: "client_user_activities_master_activity_id_fk"
    add_foreign_key "client_user_activities", "users", name: "client_user_activities_user_id_fk"
    add_foreign_key "master_checklist_options", "master_activities", name: "master_checklist_options_master_activity_id_fk"
    add_foreign_key "payment_histories", "clients", name: "payment_histories_client_id_fk"
  end
end
