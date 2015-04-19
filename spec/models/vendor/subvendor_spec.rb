require 'spec_helper'

describe Vendor::Subvendor do
  it "is invalid without belonging to vendor_vendor" do
    vendorless_sub = build(:vendor_subvendor, vendor_vendor: nil)
    vendorless_sub.valid?
    expect(vendorless_sub.errors[:vendor_vendor]).to(
      include "can't be blank")
  end

  it "is invalid without belonging to place_city" do
    cityless_sub = build(:vendor_subvendor, place_city: nil)
    cityless_sub.valid?
    expect(cityless_sub.errors[:place_city]).to(
      include "can't be blank")
  end

  it "can be deleted if got no food menus under them" do
    subvendor = create(:vendor_subvendor)
    subvendor.destroy
    expect(subvendor.deleted_at).to_not be_nil
  end

  it "cannot be deleted if still got food menus under them" do
    subvendor = create(:vendor_subvendor)
    food_menu = create(:food_menu, vendor_subvendor: subvendor)
    expect(subvendor.destroy).to be false
  end

end
