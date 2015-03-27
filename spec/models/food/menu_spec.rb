require 'spec_helper'

describe Food::Menu do
  it "must have a title lah" do
  	titleless_menu = build(:food_menu, title: nil)
  	titleless_menu.valid?
  	expect(titleless_menu.errors[:title]).to include "can't be blank"
  end

  it "must be belong to a vendor" do
    vendorless_menu = build(:food_menu, vendor_vendor: nil)
    vendorless_menu.valid?
    expect(vendorless_menu.errors[:vendor_vendor]).to(
    	include "can't be blank")
  end

  it "must be under a category" do
    catless_menu = build(:food_menu, food_category: nil)
    catless_menu.valid?
    expect(catless_menu.errors[:food_category]).to include "can't be blank"
  end

  it "must have a base price" do
    priceless_menu = build(:food_menu, base_price: nil)
    priceless_menu.valid?
    expect(priceless_menu.errors[:base_price]).to include "can't be blank"
  end
end
