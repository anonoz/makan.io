require 'spec_helper'

describe Food::Menu do
  it "must have a title lah" do
  	titleless_menu = build(:food_menu, title: nil)
  	titleless_menu.valid?
  	expect(titleless_menu.errors[:title]).to include "can't be blank"
  end

  it "must be belong to a subvendor" do
    subvendorless_menu = build(:food_menu, vendor_subvendor: nil)
    subvendorless_menu.valid?
    expect(subvendorless_menu.errors[:vendor_subvendor]).to(
    	include "can't be blank")
  end

  it "must be under a category" do
    catless_menu = build(:food_menu, food_category: nil)
    catless_menu.valid?
    expect(catless_menu.errors[:food_category]).to include "can't be blank"
  end

  it "is available in subvendor opening hour" do
    subvendor = create(:vendor_subvendor)
    create(:vendor_weekly_opening_hour, vendor_subvendor: subvendor)
 
    Timecop.freeze Time.local 2015, 3, 2, 12, 00
    expect(build(:food_menu, vendor_subvendor: subvendor).available?).to be_truthy
    Timecop.return
  end
 
  it "is unavailable outside subvendor normal opening hours" do
    subvendor = create(:vendor_subvendor)
    create(:vendor_weekly_opening_hour, vendor_subvendor: subvendor)
 
    Timecop.freeze Time.local 2015, 3, 2, 10, 00
    expect(build(:food_menu, vendor_subvendor: subvendor).available?).to be_falsy
    Timecop.return
  end
 
  it "is unavailable inside subvendor special closing hours" do
    subvendor = create(:vendor_subvendor)
    create(:vendor_special_closing_hour, vendor_subvendor: subvendor)
 
    Timecop.freeze Time.local 2015, 3, 31, 8
    expect(build(:food_menu, vendor_subvendor: subvendor).available?).to be_falsy
    Timecop.return
  end
 
end
