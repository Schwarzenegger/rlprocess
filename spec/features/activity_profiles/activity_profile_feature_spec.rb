require 'rails_helper'

describe "Activity Profile Feature specs", type: :feature do
  let(:admin_user)    { create(:user, :admin, password: "password") }
  let(:manager_user)  { create(:user, :manager, password: "password") }
  let(:employee_user) { create(:user, :employee, password: "password") }

  describe "Index" do
    it "Admin Should be able to visit page" do
      activity_profile = create(:activity_profile)
      login_as(admin_user, :scope => :user)

      visit '/activity_profiles'
      expect(page).to have_selector(:id, 'activity-profiles-list')
      expect(page).to have_content(activity_profile.name)

    end

    it "Manager Should be able to visit page" do
      activity_profile = create(:activity_profile)
      login_as(manager_user, :scope => :user)
      visit '/activity_profiles'

      expect(page).to have_selector(:id, 'activity-profiles-list')
      expect(page).to have_content(activity_profile.name)
    end

    it "Employee Should NOT be able to visit page" do
      login_as(employee_user, :scope => :user)

      visit '/activity_profiles'
      expect(page.current_path).to eq root_path
    end

    it "Try to see the page without being logged in" do
      visit '/activity_profiles'
      expect(page.current_path).to eq "/users/sign_in"
    end
  end

  describe "Should open a new modal windows" do
    it "Admin should be able to open modal window with form", js: true do
      activity_profile = build(:activity_profile)
      login_as(admin_user, :scope => :user)

      visit '/activity_profiles'
      expect(page).to have_selector('.open-crud-modal')
      click_on(class: 'open-crud-modal')

      within ".modal" do
        expect(page).to have_content I18n.t('actions.add_one', model: I18n.t('activerecord.models.activity_profile').downcase)
      end
    end
  end

  describe "Should open a edit modal windows" do
    it "Admin should be able to open modal edit window with form", js: true do
      activity_profile = create(:activity_profile)
      login_as(admin_user, :scope => :user)

      visit '/activity_profiles'

      click_on(id: "activity-profile-edit-#{activity_profile.id}")

      within ".modal" do
        expect(page).to have_content I18n.t('actions.edit_model', model: I18n.t('activerecord.models.activity_profile').downcase)
      end
    end
  end

  describe "Should be able to delete" do
    it "Admin should be able to delete a activity profile", js: true do
      activity_profile = create(:activity_profile)
      login_as(admin_user, :scope => :user)

      visit '/activity_profiles'

      click_on(id: "activity-profile-delete-#{activity_profile.id}")
      accept_alert
      expect(page).to have_content I18n.t('flash.actions.destroy.notice', resource_name: I18n.t('activerecord.models.activity_profile'))

    end
  end

end
