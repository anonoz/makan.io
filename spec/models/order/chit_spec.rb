require 'spec_helper'

describe Order::Chit do
  it "is invalid without a vendor id" do
    expect(build(:order_chit, vendor_vendor_id: nil)).to be_invalid
  end

  it "is valid with a customer user id" do
    expect(build(:order_chit)).to be_valid
  end

  it "is also valid without a customer user id" do
    expect(build(:order_chit_for_offline_guest)).to be_valid
  end

  it "is valid with status of draft/ordered/rejected/accepted/delivered" do
    order_chit = build(:order_chit)

    [:draft, :ordered, :rejected, :accepted, :delivered].each do |status|
      order_chit.update(status: status)
      expect(order_chit).to be_valid
    end
  end

  it "is invalid with status of any other words" do
    order_chit = build(:order_chit)

    [:x, :y].each do |status|
      order_chit.update(status: status)
      expect(order_chit.errors[:status]).to(
        include "is not included in the list")
    end
  end
  
end
