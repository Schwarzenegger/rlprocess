class CreateActivityProfiles < ActiveRecord::Migration[5.2]
  def change
    create_table :activity_profiles do |t|
      t.string :name

      t.timestamps
    end
  end
end
