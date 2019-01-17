require 'rails_helper'

describe "User Feature Spec", type: :feature do
  let(:admin_user)    { create(:user, :admin, password: "password") }
  let(:manager_user)  { create(:user, :manager, password: "password") }
  let(:employee_user) { create(:user, :employee, password: "password") }

  describe "Index" do
    it "Admin Should be able to visit page" do
      login_as(admin_user, :scope => :user)

      visit '/users'
      expect(page).to have_selector(:id, 'users-list')
      expect(page).to have_content(admin_user.email)

    end

    it "Manager Should NOT be able to visit page" do
      login_as(manager_user, :scope => :user)

      expect{visit '/users'}.to raise_error(CanCan::AccessDenied)
    end

    it "Employee Should NOT be able to visit page" do
      login_as(employee_user, :scope => :user)

      expect{visit '/users'}.to raise_error(CanCan::AccessDenied)
    end

    it "Try to see the page without being logged in" do
      visit '/users'
      expect(page).to have_content I18n.t('devise.failure.unauthenticated')
    end
  end

  describe "Should open a new modal windows" do
    it "Admin should be able to open modal window with form", js: true do
      login_as(admin_user, :scope => :user)

      visit '/users'
      expect(page).to have_selector('.open-crud-modal')
      click_on(class: 'open-crud-modal')

      within ".modal" do
        expect(page).to have_content I18n.t('actions.add_one', model: I18n.t('activerecord.models.user').downcase)
      end
    end
  end
end
