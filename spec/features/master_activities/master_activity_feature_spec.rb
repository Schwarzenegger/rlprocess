require 'rails_helper'

describe "Master Activity Feature Spec", type: :feature do
  let(:admin_user)    { create(:user, :admin, password: "password") }
  let(:manager_user)  { create(:user, :manager, password: "password") }
  let(:employee_user) { create(:user, :employee, password: "password") }

  describe "Index Page" do
    it "Admin Should be able to visit page" do
      master_activity = create(:master_activity)
      login_as(admin_user, :scope => :user)

      visit '/master_activities'
      expect(page).to have_selector(:id, 'master-activities-list')
      expect(page).to have_content(master_activity.name)

    end

    it "Manager Should be able to visit page" do
      master_activity = create(:master_activity)
      login_as(manager_user, :scope => :user)
      visit '/master_activities'

      expect(page).to have_selector(:id, 'master-activities-list')
      expect(page).to have_content(master_activity.name)
    end

    it "Employee Should NOT be able to visit page" do
      login_as(employee_user, :scope => :user)

      expect{visit '/master_activities'}.to raise_error(CanCan::AccessDenied)
    end

    it "Try to see the page without being logged in" do
      visit '/master_activities'
      expect(page).to have_content I18n.t('devise.failure.unauthenticated')
    end
  end

  describe "Should open a new modal windows" do
    it "Admin should be able to open modal window with form", js: true do
      login_as(admin_user, :scope => :user)

      visit '/master_activities'
      expect(page).to have_selector('.open-crud-modal')
      click_on(class: 'open-crud-modal')

      within ".modal" do
        expect(page).to have_content I18n.t('actions.add_one', model: I18n.t('activerecord.models.master_activity').downcase)
      end
    end
  end
end
