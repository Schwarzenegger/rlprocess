require 'rails_helper'

RSpec.describe ActivityWorker do
  it "should enque worker" do
     expect { ActivityWorker.perform_async() }.to change(ActivityWorker.jobs, :size).by(1)
  end

  it "Should create a right deadline for a invalid day on february" do
    user = create(:user, :admin)
    client = create(:client)
    master_activity = create(:master_activity, frequency: "montly", deadline_day: 31)
    cua_1 = create(:client_user_activity, client: client, user: user, master_activity: master_activity)
    allow(Date).to receive(:today) { Date.new(2019,2,1) }
    ActivityWorker.new.perform()
    expect(Activity.count).to eq 1
    expect(Activity.first.deadline).to eq Date.new(2019,2,28)
  end

  it "should create the right activities for the right month passing ids" do
    user_1 = create(:user, :admin)
    user_2 = create(:user, :employee)
    user_3 = create(:user, :manager)

    client_1 = create(:client)
    client_2 = create(:client)
    client_3 = create(:client)

    master_activity_1 = create(:master_activity, frequency: "annual", deadline_month: [1], deadline_day: 15)
    master_activity_2 = create(:master_activity, frequency: "annual", deadline_month: [2], deadline_day: 15)
    master_activity_3 = create(:master_activity, frequency: "montly", deadline_day: 1)
    master_activity_4 = create(:master_activity, frequency: "montly", deadline_day: 2)
    master_activity_5 = create(:master_activity, frequency: "quarterly", deadline_day: 2, deadline_month: [1,4,7,12])

    cua_1 = create(:client_user_activity, client: client_1, user: user_1, master_activity: master_activity_1)
    cua_2 = create(:client_user_activity, client: client_2, user: user_1, master_activity: master_activity_1)
    cua_3 = create(:client_user_activity, client: client_3, user: user_1, master_activity: master_activity_1)
    cua_4 = create(:client_user_activity, client: client_1, user: user_1, master_activity: master_activity_2)
    cua_5 = create(:client_user_activity, client: client_2, user: user_1, master_activity: master_activity_2)
    cua_6 = create(:client_user_activity, client: client_1, user: user_1, master_activity: master_activity_3)
    cua_7 = create(:client_user_activity, client: client_1, user: user_1, master_activity: master_activity_4)
    cua_8 = create(:client_user_activity, client: client_1, user: user_1, master_activity: master_activity_5)
    cua_9 = create(:client_user_activity, client: client_2, user: user_1, master_activity: master_activity_5)

    allow(Date).to receive(:today) { Date.new(2019,1,1) }
    ActivityWorker.new.perform([cua_6.id])
    expect(Activity.count).to eq 1
  end

  it "should create the right activities for that month running with all" do
    user_1 = create(:user, :admin)
    user_2 = create(:user, :employee)
    user_3 = create(:user, :manager)

    client_1 = create(:client)
    client_2 = create(:client)
    client_3 = create(:client)

    master_activity_1 = create(:master_activity, frequency: "annual", deadline_month: [1], deadline_day: 15)
    master_activity_2 = create(:master_activity, frequency: "annual", deadline_month: [2], deadline_day: 15)
    master_activity_3 = create(:master_activity, frequency: "montly", deadline_day: 1)
    master_activity_4 = create(:master_activity, frequency: "montly", deadline_day: 2)
    master_activity_5 = create(:master_activity, frequency: "quarterly", deadline_day: 2, deadline_month: [1,4,7,12])

    create(:client_user_activity, client: client_1, user: user_1, master_activity: master_activity_1)
    create(:client_user_activity, client: client_2, user: user_1, master_activity: master_activity_1)
    create(:client_user_activity, client: client_3, user: user_1, master_activity: master_activity_1)
    create(:client_user_activity, client: client_1, user: user_1, master_activity: master_activity_2)
    create(:client_user_activity, client: client_2, user: user_1, master_activity: master_activity_2)
    create(:client_user_activity, client: client_1, user: user_1, master_activity: master_activity_3)
    create(:client_user_activity, client: client_1, user: user_1, master_activity: master_activity_4)
    create(:client_user_activity, client: client_1, user: user_1, master_activity: master_activity_5)
    create(:client_user_activity, client: client_2, user: user_1, master_activity: master_activity_5)

    create(:client_user_activity, client: client_1, user: user_2, master_activity: master_activity_1)
    create(:client_user_activity, client: client_2, user: user_2, master_activity: master_activity_1)
    create(:client_user_activity, client: client_3, user: user_2, master_activity: master_activity_1)
    create(:client_user_activity, client: client_1, user: user_2, master_activity: master_activity_2)
    create(:client_user_activity, client: client_2, user: user_2, master_activity: master_activity_2)
    create(:client_user_activity, client: client_1, user: user_2, master_activity: master_activity_3)
    create(:client_user_activity, client: client_1, user: user_2, master_activity: master_activity_4)
    create(:client_user_activity, client: client_1, user: user_2, master_activity: master_activity_5)
    create(:client_user_activity, client: client_2, user: user_2, master_activity: master_activity_5)

    create(:client_user_activity, client: client_1, user: user_3, master_activity: master_activity_1)
    create(:client_user_activity, client: client_2, user: user_3, master_activity: master_activity_1)
    create(:client_user_activity, client: client_3, user: user_3, master_activity: master_activity_1)
    create(:client_user_activity, client: client_1, user: user_3, master_activity: master_activity_2)
    create(:client_user_activity, client: client_2, user: user_3, master_activity: master_activity_2)
    create(:client_user_activity, client: client_1, user: user_3, master_activity: master_activity_3)
    create(:client_user_activity, client: client_1, user: user_3, master_activity: master_activity_4)
    create(:client_user_activity, client: client_1, user: user_3, master_activity: master_activity_5)
    create(:client_user_activity, client: client_2, user: user_3, master_activity: master_activity_5)

    #Should create 7 activities to january
    allow(Date).to receive(:today) { Date.new(2019,1,1) }
    ActivityWorker.new.perform
    expect(Activity.count).to eq 7

    # If run again, should not create a new activity
    ActivityWorker.new.perform
    expect(Activity.count).to eq 7

    #Should create 4 new activities on february
    allow(Date).to receive(:today) { Date.new(2019,2,1) }
    ActivityWorker.new.perform
    expect(Activity.count).to eq 11
  end
end
