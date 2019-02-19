require 'rails_helper'

describe "Sign In", type: :feature do
  let(:admin_user) { create(:user, :admin, password: "password") }

  it "Sucessfull Sign In" do
    visit '/users/sign_in'
    within(".simple_form") do
      fill_in 'user_email', with: admin_user.email
      fill_in 'user_password', :with => 'password'
    end
    click_button I18n.t('devise.sessions.sign_in')
    expect(page.current_path).to eq root_path
  end

  it "Unsucessfull Sign In" do
    visit '/users/sign_in'
    within(".simple_form") do
      fill_in 'user_email', with: admin_user.email
      fill_in 'user_password', :with => 'wrong_password'
    end
    click_button I18n.t('devise.sessions.sign_in')
    expect(page.current_path).to eq "/users/sign_in"
  end
end
