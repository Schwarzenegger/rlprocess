require 'rails_helper'

RSpec.describe MasterActivity, type: :model do
  it "should have a factory" do
    expect(FactoryBot.build(:master_activity)).to be_valid
  end

  context "Should Respond" do
    it { should respond_to(:name) }
    it { should respond_to(:category) }
    it { should respond_to(:frequency) }
    it { should respond_to(:deadline_year) }
    it { should respond_to(:deadline_month) }
    it { should respond_to(:deadline_day) }
    it { should respond_to(:has_checkbox) }
    it { should respond_to(:checkbox_options) }
    it { should respond_to(:created_at) }
    it { should respond_to(:updated_at) }
  end

  context "Validations" do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:category) }
    it { should validate_presence_of(:frequency) }
  end

end
