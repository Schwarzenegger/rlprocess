class AddParthnerInformationOnClient < ActiveRecord::Migration[5.2]
  def change
    add_column :clients, :nickname, :string
    add_column :clients, :partner_name, :string
    add_column :clients, :partner_cpf, :string
  end
end
