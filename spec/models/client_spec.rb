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
    it { should respond_to(:created_at) }
    it { should respond_to(:updated_at) }
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
