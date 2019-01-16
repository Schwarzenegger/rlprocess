describe "User Index Spec", type: :feature do
  let(:admin_user)    { create(:user, :admin, password: "password") }
  let(:manager_user)  { create(:user, :manager, password: "password") }
  let(:employee_user) { create(:user, :employee, password: "password") }

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
