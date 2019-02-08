require 'rails_helper'

RSpec.describe ClientUserActivity, type: :model do
  it "should have a factory" do
    expect(FactoryBot.build(:client_user_activity)).to be_valid
  end

  context "Should Respond" do
    it { should respond_to(:client_id) }
    it { should respond_to(:client) }
    it { should respond_to(:user_id) }
    it { should respond_to(:user) }
    it { should respond_to(:master_activity_id) }
    it { should respond_to(:master_activity) }
    it { should respond_to(:created_at) }
    it { should respond_to(:updated_at) }
  end

  context "Associations" do
    it { should belong_to(:client) }
    it { should belong_to(:user) }
    it { should belong_to(:master_activity) }
  end

end
