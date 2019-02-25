require 'rails_helper'

RSpec.describe Activity, type: :model do
  it "should have a factory" do
    expect(FactoryBot.build(:activity)).to be_valid
  end

  context "Should Respond" do
    it { should respond_to(:client_id) }
    it { should respond_to(:client) }
    it { should respond_to(:user_id) }
    it { should respond_to(:user) }
    it { should respond_to(:master_activity_id) }
    it { should respond_to(:master_activity) }
    it { should respond_to(:when_moved_to_progress) }
    it { should respond_to(:when_moved_to_done) }
    it { should respond_to(:status) }
    it { should respond_to(:deadline) }
    it { should respond_to(:identifier) }
    it { should respond_to(:created_at) }
    it { should respond_to(:updated_at) }
  end

  context "Associations" do
    it { should belong_to(:client) }
    it { should belong_to(:user) }
    it { should belong_to(:master_activity) }
    it { should have_many(:activiy_check_lists) }
  end

  context "Enums" do
    it { should define_enum_for(:status).with_values(
                                    todo: 1,
                                   doing: 2,
                                    done: 3,
                                archived: 4) }
  end


  context "Instance Methods" do
    describe "set_identifier" do
      it "Should set right identifier when called" do
        client = create(:client)
        master_activity_1 = create(:master_activity, frequency: "montly")
        master_activity_2 = create(:master_activity, frequency: "quarterly")
        master_activity_3 = create(:master_activity, frequency: "annual")
        master_activity_4 = create(:master_activity, frequency: "single_time")

        activity = FactoryBot.build(:activity, client: client, master_activity: master_activity_1, identifier: nil)

        expect(activity.identifier).to eq nil
        activity.set_identifier
        expect(activity.identifier).to eq "C#{client.id}-MA#{master_activity_1.id}/M/#{Date.today.month}/#{Date.today.year}"

        activity.master_activity = master_activity_2
        activity.set_identifier
        expect(activity.identifier).to eq "C#{client.id}-MA#{master_activity_2.id}/Q/#{Date.today.month}/#{Date.today.year}"

        activity.master_activity = master_activity_3
        activity.set_identifier
        expect(activity.identifier).to eq "C#{client.id}-MA#{master_activity_3.id}/A/#{Date.today.month}/#{Date.today.year}"


        activity.master_activity = master_activity_4
        activity.set_identifier
        expect(activity.identifier).to eq "C#{client.id}-MA#{master_activity_4.id}/S/#{Date.today.month}/#{Date.today.year}"

      end
    end
  end

end
