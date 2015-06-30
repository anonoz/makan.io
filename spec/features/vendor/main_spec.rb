require 'spec_helper'

describe "Vendor Admin Kanban", js: true do
  it "sees a blank kanban" do
    vendor_user = create(:vendor_user)
    vendor_sign_in vendor_user
    expect(page).to have_content "Incoming Orders"
  end

  it "sees an incoming order with 3s ago if the order is made 3s ago" do
  	Timecop.freeze 2015, 3, 1, 11, 00
  	vendor_user = create(:vendor_user)
    incoming_order = create(:order_chit, vendor_vendor: vendor_user.vendor, status: :ordered)
  end

  it "sees a rejected order with 1m ago if order is rejected 1m ago"
  it "sees an accepted order 10m ago if order is accepted 10m ago"
  it "sees a delivered order 30m ago if order is delivered 30m ago"
end
