require 'spec_helper'

describe "Admin User Management", js: true do
  it "Adding a new admin user" do
    admin = create(:vendor_user)
    vendor_sign_in admin

    click_link "Admin Users"
    expect {
      temporary_pwd = Faker::Internet.password(12)

      fill_in "E-mail", with: Faker::Internet.email
      fill_in "Permission Level", with: 90
      fill_in "Password", with: temporary_pwd
      fill_in "Confirm Password", with: temporary_pwd
      click_button "Save"
    }.to change(Vendor::User, :count).by(1)
  end
end
