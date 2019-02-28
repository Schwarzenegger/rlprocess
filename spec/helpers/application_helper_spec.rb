require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do
  describe "display_flash_messages" do
    it "should display success toastr message" do
      flash[:notice] = "Test Message"
      displayed_flash = display_flash_messages(flash)
      expect(displayed_flash).to eq "<script>toastr.success('Test Message');</script>"
    end

    it "should display errror toastr message" do
      flash[:alert] = "Test Message"
      displayed_flash = display_flash_messages(flash)
      expect(displayed_flash).to eq "<script>toastr.error('Test Message');</script>"
    end
  end

  describe "fa" do
    it "should display the font awesome icon" do
      fa_icon_html = fa("calendar")
      expect(fa_icon_html).to eq "<i class='fa fa-calendar'></i>"
    end
  end

  describe "ldate" do
    it "should return empty if no date is passed" do
      expect(ldate()).to eq ""
    end
  end

  describe "translate_enum" do
    it "should point to the right enum translation" do
      expect(translate_enum("user", "role", "admin")).to eq I18n.t("enums.user.role.admin")
    end
  end
end
