require 'spec_helper'

describe "Vendor Admin Kanban", js: true do
  it "Seeing a blank kanban" do
    vendor_user = create(:vendor_user)
    vendor_sign_in vendor_user
    expect(page).to have_content "Incoming Orders"
  end
end
