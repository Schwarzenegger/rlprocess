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
      expect(page.current_path).to eq "/users/sign_in"
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

  describe "Should open a edit modal windows" do
    it "Admin should be able to open modal edit window with form", js: true do
      user = create(:user)
      login_as(admin_user, :scope => :user)

      visit '/users'

      click_on(id: "user-edit-#{user.id}")

      within ".modal" do
        expect(page).to have_content I18n.t('actions.edit_model', model: I18n.t('activerecord.models.user').downcase)
      end
    end
  end

  describe "Should be able to delete" do
    it "Admin should be able to delete a user", js: true do
      user = create(:user)
      login_as(admin_user, :scope => :user)

      visit '/users'

      click_on(id: "user-delete-#{user.id}")
      accept_alert
      expect(page).to have_content I18n.t('flash.actions.destroy.notice', resource_name: I18n.t('activerecord.models.user'))

    end
  end
end
