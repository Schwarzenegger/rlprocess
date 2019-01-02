require 'rails_helper'

RSpec.describe ActivityProfile, type: :model do
  it "should have a factory" do
    expect(FactoryBot.build(:activity_profile)).to be_valid
  end

  context "Should Respond" do
    it { should respond_to(:name) }
  end

  context "Associations" do
    it { should have_and_belong_to_many(:master_activities) }
  end

  context "Validations" do
    it { should validate_presence_of(:name) }
  end
end
