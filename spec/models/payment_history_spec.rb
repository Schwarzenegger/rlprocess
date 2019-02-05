require 'rails_helper'

RSpec.describe PaymentHistory, type: :model do
  it "should have a factory" do
    expect(FactoryBot.build(:payment_history)).to be_valid
  end

  context "Should Respond" do
    it { should respond_to(:client_id) }
    it { should respond_to(:client) }
    it { should respond_to(:receipt_date) }
    it { should respond_to(:value) }
    it { should respond_to(:created_at) }
    it { should respond_to(:updated_at) }
  end

  context "Associations" do
    it { should belong_to(:client) }
  end

  context "Validations" do
    it { should validate_presence_of(:receipt_date) }
    it { should validate_presence_of(:value) }
  end
end
