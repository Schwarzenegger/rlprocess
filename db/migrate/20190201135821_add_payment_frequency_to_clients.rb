class AddPaymentFrequencyToClients < ActiveRecord::Migration[5.2]
  def change
    add_column :clients, :payment_frequency, :integer
  end
end
