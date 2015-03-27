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
end
