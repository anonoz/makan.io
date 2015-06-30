require 'spec_helper'

describe "Vendor Admin Subvendor Special Closing Hours", js: true do
  it "set food menu to be unavailable once special closing time is set" do
    vendor_user = create(:vendor_user)
    ah_beng = create(:vendor_subvendor, vendor_vendor: vendor_user.vendor)
    nasi_lemak = create(:food_menu, vendor_subvendor: ah_beng)
    create(:vendor_weekly_opening_hour, vendor_subvendor: ah_beng)

    vendor_sign_in vendor_user
    find_link("Subvendors").hover
    click_link "Special Closing Hours"

    Timecop.travel 2015, 06, 29, 12, 00 # Monday noon

    expect {
      
      find("#vendor_special_closing_hour_start_at").set("2015-06-29T11:00:00")
      find("#vendor_special_closing_hour_end_at").set("2015-06-29T13:00:00")
      click_button "Save"

    }.to change {

      nasi_lemak.available?

    }.from(true).to(false)

    Timecop.return
  end
end
