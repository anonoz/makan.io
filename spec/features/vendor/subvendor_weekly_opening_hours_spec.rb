require 'spec_helper'

describe 'Vendor Admin Subvendor Weekly Opening Hours', js: true do
  it "changes food menu from unavaialble to available after setting subvendor opening hour" do
    vendor_user = create(:vendor_user)
    ah_beng = create(:vendor_subvendor, vendor_vendor: vendor_user.vendor)
    nasi_lemak = create(:food_menu, vendor_subvendor: ah_beng)
    
    vendor_sign_in vendor_user
    find_link("Subvendors").hover
    click_link "Weekly Opening Hours"
    expect(page).to have_content ah_beng.title

    Timecop.travel 2015, 06, 29, 12, 00 # Monday noon

    expect {

      find("#vendor_weekly_opening_hour_wday").set("monday")
      find("#vendor_weekly_opening_hour_start_at").set("0800")
      find("#vendor_weekly_opening_hour_end_at").set("1500")
      click_button "Save"

    }.to change {

      nasi_lemak.available?

    }.from(false).to(true)

    Timecop.return
  end
	
end
