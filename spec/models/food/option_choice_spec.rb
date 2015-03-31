require 'spec_helper'

describe Food::OptionChoice do
  it "is valid with a associated food_option" do
    expect(build(:food_option_choice)).to be_valid
  end

  it "is invalid without a associated food_option" do
    expect(build(:food_option_choice, food_option: nil)).to be_invalid
  end

  it "is valid with min and max of 0 and above" do
    expect(build(:food_option_choice, min: 1, max: 1)).to be_valid
  end

  it "is invalid with min of negative number" do
    expect(build(:food_option_choice, min: -1)).to be_invalid
  end

  it "is invalid with max of negative number" do
    expect(build(:food_option_choice, min: -1)).to be_invalid
  end

  it "is valid with a default quantity of 0 and above" do
    [0, 1].each do |num|
      expect(build(:food_option_choice, default_quantity: num)).to be_valid
    end
  end

  it "is invalid with a default quantity of negative number" do
    expect(build(:food_option_choice, default_quantity: -1)).to be_invalid
  end

  it "is valid with unit amount of 0 and above" do
    [0, 100].each do |num|
      expect(build(:food_option_choice, unit_amount: num)).to be_valid
    end
  end

end
