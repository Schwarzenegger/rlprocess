require 'rails_helper'

RSpec.describe MasterActivity, type: :model do
  it "should have a factory" do
    expect(FactoryBot.build(:master_activity)).to be_valid
  end

  context "Should Respond" do
    it { should respond_to(:name) }
    it { should respond_to(:category) }
    it { should respond_to(:frequency) }
    it { should respond_to(:deadline_date) }
    it { should respond_to(:deadline_month) }
    it { should respond_to(:deadline_day) }
    it { should respond_to(:competence) }
    it { should respond_to(:start_date) }
    it { should respond_to(:created_at) }
    it { should respond_to(:updated_at) }
  end

  context "Enums" do
    it { should define_enum_for(:category).with_values(
                     accounting: 1,
                     individual: 2,
                         fiscal: 3) }

    it { should define_enum_for(:frequency).with_values(
                        montly: 1,
                     quarterly: 2,
                         annual: 3,
                   single_time: 4 ) }

    it { should define_enum_for(:frequency).with_values(
                      montly: 1,
                   quarterly: 2,
                       annual: 3,
                 single_time: 4 ) }

  end

  context "Associations" do
    it { should have_and_belong_to_many(:activity_profiles) }
    it { should have_many(:client_user_activities) }
    it { should have_many(:activities) }
  end

  context "Validations" do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:category) }
    it { should validate_presence_of(:frequency) }
  end

end
