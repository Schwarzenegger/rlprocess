describe "Client Index Spec", type: :feature do
  let(:admin_user)    { create(:user, :admin, password: "password") }
  let(:manager_user)  { create(:user, :manager, password: "password") }
  let(:employee_user) { create(:user, :employee, password: "password") }

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
