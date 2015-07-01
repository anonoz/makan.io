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

    Timecop.freeze 2015, 3, 1, 11, 00, 3
    vendor_sign_in vendor_user

    within("#incoming-orders-column") do
      expect(page).to have_content "3"
      expect(page).to have_content "secs ago"
    end

    Timecop.return
  end

  it "sees a rejected order with 2m ago if order is rejected 2m ago" do
    Timecop.freeze 2015, 3, 1, 11, 00
    vendor_user = create(:vendor_user)
    rejected_order = create(:order_chit, vendor_vendor: vendor_user.vendor, status: :ordered)
    rejected_order.reject!

    Timecop.freeze 2015, 3, 1, 11, 02, 24
    vendor_sign_in vendor_user

    within("#rejected-orders-column") do
      expect(page).to have_content "2"
      expect(page).to have_content "mins ago"
    end

    Timecop.return
  end

  it "sees an accepted order 10m ago if order is accepted 10m ago" do
    Timecop.freeze 2015, 3, 1, 11, 00
    vendor_user = create(:vendor_user)
    accepted_order = create(:order_chit, vendor_vendor: vendor_user.vendor, status: :ordered)
    accepted_order.accept!

    Timecop.freeze 2015, 3, 1, 11, 10, 12
    vendor_sign_in vendor_user

    within("#accepted-orders-column") do
      expect(page).to have_content "10"
      expect(page).to have_content "mins ago"
    end

    Timecop.return
  end

  it "sees a delivered order 30m ago if order is delivered 30m ago" do
    Timecop.freeze 2015, 3, 1, 11, 00
    vendor_user = create(:vendor_user)
    delivered_order = create(:order_chit, vendor_vendor: vendor_user.vendor, status: :ordered)
    delivered_order.accept!
    delivered_order.deliver!

    Timecop.freeze 2015, 3, 1, 11, 30, 10
    vendor_sign_in vendor_user

    within("#delivered-orders-column") do
      expect(page).to have_content "30"
      expect(page).to have_content "mins ago"
    end

    Timecop.return
  end
end
