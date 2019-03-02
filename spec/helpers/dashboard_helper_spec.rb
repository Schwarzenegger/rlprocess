require 'rails_helper'

RSpec.describe DashboardHelper, type: :helper do
  describe "activity_status_label" do
    it "should return label success if activity is done" do
      activity = build(:activity, status: "done")
      label = activity_status_label(activity)
      expect(label).to include("label-success")
    end

    it "should return label danger if activity is past deadline" do
      activity = build(:activity, status: "todo", deadline: Date.today - 1)
      label = activity_status_label(activity)
      expect(label).to include("label-danger")
    end

    it "should return label warning if activity is close to deadline" do
      activity = build(:activity, status: "todo", deadline: Date.today + 1)
      label = activity_status_label(activity)
      expect(label).to include("label-warning")
    end

    it "should return label success if activity is not close to deadline" do
      activity = build(:activity, status: "todo", deadline: Date.today + 10)
      label = activity_status_label(activity)
      expect(label).to include("label-primary")
    end
  end

  describe "month_year_name" do
    it "should write the correct month value jan/2019" do
      string = month_year_name(1, 2019)
      expect(string).to eq "#{I18n.t('date.month_names')[0]}/2019"
    end
  end

  describe "how_close_to_deadline" do
    it "should write when the activity was done" do
      done_date = DateTime.now
      activity = build(:activity, status: "done", when_moved_to_done: done_date)
      string = how_close_to_deadline(activity)

      expect(string).to eq I18n.t("views.dashboard.done_activity", date: I18n.l(done_date))
    end

    it "should write how many days the activity is late" do
      activity = build(:activity, status: "todo", deadline: Date.today - 2)

      string = how_close_to_deadline(activity)

      expect(string).to eq I18n.t("views.dashboard.late_activity", days: 2)
    end

    it "should write that is due today" do
      activity = build(:activity, status: "todo", deadline: Date.today)

      string = how_close_to_deadline(activity)

      expect(string).to eq I18n.t("views.dashboard.deadline_today")
    end

    it "should write that is not late" do
      activity = build(:activity, status: "todo", deadline: Date.today + 2)

      string = how_close_to_deadline(activity)

      expect(string).to eq I18n.t("views.dashboard.days_to_be_late", days: 2)
    end
  end
end
