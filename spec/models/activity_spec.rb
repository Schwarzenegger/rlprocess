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
    it { should have_many(:activity_check_lists) }
  end

  context "Validations" do
    it { should validate_uniqueness_of(:identifier) }
  end

  context "Callbacks" do
    describe "#generate_access_token" do
      it { should callback(:set_identifier).before(:validation) }
    end
  end

  context "Enums" do
    it { should define_enum_for(:status).with_values(
                                    todo: 1,
                                   doing: 2,
                                    done: 3,
                                archived: 4) }

    describe "Enum States" do
      it "should start a activity" do
        activity = FactoryBot.build(:activity)
        expect(activity.status).to eq "todo"
        expect(activity.when_moved_to_progress).to eq nil
        expect(activity.when_moved_to_done).to eq nil
        activity.start
        expect(activity.status).to eq "doing"
        expect(activity.when_moved_to_progress).not_to eq nil
        expect(activity.when_moved_to_done).to eq nil
      end

      it "should finish a activity" do
        activity = FactoryBot.build(:activity, status: "doing", when_moved_to_progress: DateTime.now)
        expect(activity.status).to eq "doing"
        expect(activity.when_moved_to_progress).not_to eq nil
        expect(activity.when_moved_to_done).to eq nil
        activity.finish
        expect(activity.status).to eq "done"
        expect(activity.when_moved_to_progress).not_to eq nil
        expect(activity.when_moved_to_done).not_to eq nil
      end

      it "should restart a activity" do
        activity = FactoryBot.build(:activity, status: "done",
          when_moved_to_progress: DateTime.now, when_moved_to_done: DateTime.now)
        expect(activity.status).to eq "done"
        expect(activity.when_moved_to_progress).not_to eq nil
        expect(activity.when_moved_to_done).not_to eq nil
        activity.restart
        expect(activity.status).to eq "todo"
        expect(activity.when_moved_to_progress).to eq nil
        expect(activity.when_moved_to_done).to eq nil
      end
    end
  end


  context "Instance Methods" do
    describe "is_past_deadlines?" do
      it "should return true if activity is past deadline" do
        activity = FactoryBot.build(:activity, deadline: Date.today - 1)
        expect(activity.is_past_deadlines?).to eq true
      end

      it "should return false if activity is not past deadline" do
        activity = FactoryBot.build(:activity, deadline: Date.today + 1)
        expect(activity.is_past_deadlines?).to eq false
      end
    end

    describe "is_close_to_deadline?" do
      it "should return true if activity is close deadline" do
        activity = FactoryBot.build(:activity, deadline: Date.today + 2)
        expect(activity.is_close_to_deadline?).to eq true
      end

      it "should return false if activity is close deadline" do
        activity = FactoryBot.build(:activity, deadline: Date.today + 3)
        expect(activity.is_close_to_deadline?).to eq false
      end

    end

    describe "has_done_all_checklists?" do
      it "should return true if has no checklist" do
        activity = FactoryBot.build(:activity)
        expect(activity.has_done_all_checklists?).to eq true
      end

      it "should return false if has checklist and they are not done" do
        activity = FactoryBot.create(:activity)
        FactoryBot.create(:activity_check_list, activity: activity, done: false)
        expect(activity.has_done_all_checklists?).to eq false
      end

      it "should return true if has checklist and they are done" do
        activity = FactoryBot.create(:activity)
        FactoryBot.create(:activity_check_list, activity: activity, done: true)
        expect(activity.has_done_all_checklists?).to eq true
      end

    end

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
        expect(activity.identifier).to_not eq nil
      end
    end
  end
end
