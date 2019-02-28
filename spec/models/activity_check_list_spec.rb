require 'rails_helper'

RSpec.describe ActivityCheckList, type: :model do
  it "should have a factory" do
    expect(FactoryBot.build(:activity_check_list)).to be_valid
  end

  context "Should Respond" do
    it { should respond_to(:activity) }
    it { should respond_to(:activity_id) }
    it { should respond_to(:name) }
    it { should respond_to(:done) }
    it { should respond_to(:created_at) }
    it { should respond_to(:updated_at) }
  end

  context "Associations" do
    it { should belong_to(:activity) }
  end
end
