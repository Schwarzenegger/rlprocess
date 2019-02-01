require 'rails_helper'

RSpec.describe Client, type: :model do
  it "should have a factory" do
    expect(FactoryBot.build(:client)).to be_valid
  end

  context "Should Respond" do
    it { should respond_to(:cnpj) }
    it { should respond_to(:social_name) }
    it { should respond_to(:municipal_inscription) }
    it { should respond_to(:state_inscription) }
    it { should respond_to(:date_of_founding) }
    it { should respond_to(:taxation) }
    it { should respond_to(:contact) }
    it { should respond_to(:email) }
    it { should respond_to(:telephone) }
    it { should respond_to(:iss_password) }
    it { should respond_to(:simples_password) }
    it { should respond_to(:start_accounting) }
    it { should respond_to(:end_accounting) }
    it { should respond_to(:honorary) }
    it { should respond_to(:observations) }
    it { should respond_to(:nickname) }
    it { should respond_to(:partner_name) }
    it { should respond_to(:partner_cpf) }
    it { should respond_to(:payment_frequency) }
    it { should respond_to(:created_at) }
    it { should respond_to(:updated_at) }
  end

  context "Enums" do
    it { should define_enum_for(:taxation).with_values(
                             simples: 1,
                     presumed_profit: 2,
                         real_profit: 3,
                         deactivated: 4,
                         exempt: 5,
                         others: 6) }

    it { should define_enum_for(:payment_frequency).with_values(
                            montly: 1,
                    quarterly: 2,
                        annual: 3) }
  end

  context "Associations" do
    it { should have_and_belong_to_many(:activity_profiles) }
  end

  context "Validations" do
    it { should validate_presence_of(:cnpj) }
    it { should validate_presence_of(:social_name) }
    it { should validate_presence_of(:date_of_founding) }
    it { should validate_presence_of(:taxation) }
    it { should validate_presence_of(:contact) }
    it { should validate_presence_of(:telephone) }
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:start_accounting) }
  end

end
