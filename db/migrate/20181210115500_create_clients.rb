class CreateClients < ActiveRecord::Migration[5.2]
  def change
    create_table :clients do |t|
      t.string :cnpj
      t.string :social_name
      t.string :municipal_inscription
      t.string :state_inscription
      t.date :date_of_founding
      t.integer :taxation
      t.string :contact
      t.string :email
      t.string :telephone
      t.string :iss_password
      t.string :simples_password
      t.date :start_accounting
      t.date :end_accounting
      t.float :honorary
      t.text :observations

      t.timestamps
    end
  end
end
