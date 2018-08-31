require 'rails_helper'

RSpec.describe User, type: :model do
  it "should have a factory" do
    expect(FactoryBot.build(:user)).to be_valid
  end

  context "Should Respond" do
    it { should respond_to(:name) }
    it { should respond_to(:role) }
    it { should respond_to(:salary) }
    it { should respond_to(:created_at) }
    it { should respond_to(:updated_at) }
    it { should respond_to(:email) }
    it { should respond_to(:encrypted_password) }
    it { should respond_to(:reset_password_token) }
    it { should respond_to(:reset_password_sent_at) }
    it { should respond_to(:remember_created_at) }
    it { should respond_to(:sign_in_count) }
    it { should respond_to(:current_sign_in_at) }
    it { should respond_to(:last_sign_in_at) }
    it { should respond_to(:current_sign_in_ip) }
    it { should respond_to(:last_sign_in_ip) }
  end

  context "Validations" do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:role) }
    it { should validate_presence_of(:salary) }

  end

end
