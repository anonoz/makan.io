require 'spec_helper'

describe Food::MenuOption do
  it "is valid when both food_menu and food_option are associated" do
    expect(build(:food_menu_option)).to be_valid
  end

  it "is invalid without associated food menu" do
    menuless = build(:food_menu_option, food_menu: nil)
    menuless.valid?
    expect(menuless.errors[:food_menu]).to include "can't be blank"
  end

  it "is invalid without associated food option" do
    optionless = build(:food_menu_option, food_option: nil)
    optionless.valid?
    expect(optionless.errors[:food_option]).to include "can't be blank"
  end
end
