require 'rails_helper'

RSpec.describe MasterChecklistOption, type: :model do
  it "should have a factory" do
    expect(FactoryBot.build(:master_checklist_option)).to be_valid
  end

  context "Should Respond" do
    it { should respond_to(:name) }
    it { should respond_to(:created_at) }
    it { should respond_to(:updated_at) }
  end

  context "Associations" do
    it { should belong_to(:master_activity) }
  end

end
