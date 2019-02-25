class CreateActiviyCheckLists < ActiveRecord::Migration[5.2]
  def change
    create_table :activiy_check_lists do |t|
      t.references :activity
      t.string :name
      t.boolean :done, default: false

      t.timestamps
    end
  end
end
