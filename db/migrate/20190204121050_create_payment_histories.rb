class CreatePaymentHistories < ActiveRecord::Migration[5.2]
  def change
    create_table :payment_histories do |t|
      t.references :client, index: true
      t.date :receipt_date
      t.float :value

      t.timestamps
    end
  end
end
