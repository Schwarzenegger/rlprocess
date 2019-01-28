require 'rails_helper'

describe "Client Feature Specs", type: :feature do
  let(:admin_user)    { create(:user, :admin, password: "password") }
  let(:manager_user)  { create(:user, :manager, password: "password") }
  let(:employee_user) { create(:user, :employee, password: "password") }

  describe "Index Page" do
    it "Admin Should be able to visit page" do
      client = create(:client)
      login_as(admin_user, :scope => :user)

      visit '/clients'
      expect(page).to have_selector(:id, 'clients-list')
      expect(page).to have_content(client.cnpj)

    end

    it "Manager Should be able to visit page" do
      client = create(:client)
      login_as(manager_user, :scope => :user)
      visit '/clients'

      expect(page).to have_selector(:id, 'clients-list')
      expect(page).to have_content(client.cnpj)
    end

    it "Employee Should NOT be able to visit page" do
      login_as(employee_user, :scope => :user)

      expect{visit '/clients'}.to raise_error(CanCan::AccessDenied)
    end

    it "Try to see the page without being logged in" do
      visit '/clients'
      expect(page).to have_content I18n.t('devise.failure.unauthenticated')
    end
  end

  describe "Should go to client modal" do
    it "Admin should be able to open modal window with form", js: true do
      login_as(admin_user, :scope => :user)

      visit '/clients'
      expect(page).to have_selector('.open-crud-modal')
      click_on(class: 'open-crud-modal')

      expect(page).to have_content I18n.t('views.clients.edit')
    end
  end

  describe "Should go to client form" do
    it "Admin should be able to open modal edit window with form", js: true do
      client = create(:client)
      login_as(admin_user, :scope => :user)

      visit '/clients'

      click_on(id: "client-edit-#{client.id}")

      expect(page).to have_content I18n.t('views.clients.new')
    end
  end

  describe "Should be able to delete" do
    it "Admin should be able to delete a client", js: true do
      client = create(:client)
      login_as(admin_user, :scope => :user)

      visit '/clients'

      click_on(id: "client-delete-#{client.id}")
      accept_alert
      expect(page).to have_content I18n.t('flash.actions.destroy.notice', resource_name: I18n.t('activerecord.models.client'))

    end
  end

end
