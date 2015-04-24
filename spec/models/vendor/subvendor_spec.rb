require 'spec_helper'

describe Vendor::Subvendor do
  it "is invalid without belonging to vendor_vendor" do
    vendorless_sub = build(:vendor_subvendor, vendor_vendor: nil)
    vendorless_sub.valid?
    expect(vendorless_sub.errors[:vendor_vendor]).to(
      include "can't be blank")
  end

  it "is invalid without belonging to city" do
    cityless_sub = build(:vendor_subvendor, city: nil)
    cityless_sub.valid?
    expect(cityless_sub.errors[:city]).to(
      include "can't be blank")
  end

  it "is valid if its in Setapak" do
    expect(build(:vendor_subvendor, city: :setapak)).to be_valid
    expect(build(:vendor_subvendor, city: "setapak")).to be_valid
  end

  it "is invalid if its in unlisted cities such as Penang" do
    georgetown = build(:vendor_subvendor, city: :penang)
    georgetown.valid?
    expect(georgetown.errors[:city]).to include "is not included in the list"
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

  it "is open in 12PM if it normally opens from 11AM-3PM" do
    subvendor = create(:vendor_subvendor)
    create(:vendor_weekly_opening_hour, vendor_subvendor: subvendor)

    Timecop.freeze Time.local 2015, 3, 2, 12, 00
    expect(subvendor.open?).to be_truthy
    Timecop.return
  end

  it "is closed in 10AM if it normally opens from 11AM-3PM" do
    subvendor = create(:vendor_subvendor)
    create(:vendor_weekly_opening_hour, vendor_subvendor: subvendor)

    Timecop.freeze Time.local 2015, 3, 2, 10, 00
    expect(subvendor.open?).to be_falsy
    Timecop.return
  end

  it "is closed if it normally opens but closed for daughter wedding" do
    subvendor = create(:vendor_subvendor)
    create(:vendor_special_closing_hour, vendor_subvendor: subvendor)

    Timecop.freeze Time.local 2015, 3, 31, 8
    expect(subvendor.open?).to be_falsy
    Timecop.return
  end
    
end
