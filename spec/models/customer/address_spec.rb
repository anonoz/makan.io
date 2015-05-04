require 'spec_helper'

describe Customer::Address do
  it "must belong to a user" do
    userless_address = build(:customer_address, customer_user: nil)
    userless_address.valid?
    expect(userless_address.errors[:customer_user]).to include "can't be blank"
  end

  it "must be located in an area stated" do
    arealess_address = build(:customer_address, place_area: nil)
    arealess_address.valid?
    expect(arealess_address.errors[:place_area]).to include "can't be blank"
  end

  it "is valid with an address" do
    expect(build(:customer_address)).to be_valid
  end

  it "is invalid without an address" do
  	doorless_address = build(:customer_address, address: nil)
    doorless_address.valid?
    expect(doorless_address.errors[:address]).to include "can't be blank"
  end

  it "returns 'PV10 - E-101-A' from human_readable method if its in PV10 area and has E-101-A as address" do
    pv10 = create(:place_area, name: "PV10")
    e101a = build(:customer_address, place_area: pv10, address: "E-101-A")
    expect(e101a.human_readable).to eq "PV10 - E-101-A"
  end
end
