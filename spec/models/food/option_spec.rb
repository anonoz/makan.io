require 'spec_helper'

describe Food::Option do
  it "is valid when belong to a menu" do
    food_menu = create(:food_menu)
    food_option = build(:food_option, food_menu: food_menu)
    food_option.valid?
    expect(food_option).to be_valid
  end

  it "is invalid when it doesnt belong to a food_menu" do
    food_option = build(:food_option, food_menu: nil)
    food_option.valid?
    expect(food_option.errors[:food_menu]).to include "can't be blank"
  end

  it "is valid with a title" do
    expect(build(:food_option)).to be_valid
  end

  it "is invalid without a title" do
    nameless_option = build(:food_option, title: nil)
    nameless_option.valid?
    expect(nameless_option.errors[:title]).to include "can't be blank"
  end

  it "is valid with a jenis" do
    option_with_checkboxes = build(:food_option_with_checkboxes)
    expect(option_with_checkboxes).to be_valid
  end

  it "is invalid without a jenis" do
    traitless_option = build(:food_option, jenis: nil)
    traitless_option.valid?
    expect(traitless_option.errors[:jenis]).to include "can't be blank"
  end

  it "is valid when jenis is from 1 to 3" do
    (1..3).each do |jenis_id|
      expect(build(:food_option, jenis: jenis_id)).to be_valid
    end
  end

  it "is invalid when jenis is outside 1, 2, 3" do
    [-1, 0, 4, 5].each do |invalid_jenis_id|
      food_option = build(:food_option, jenis: invalid_jenis_id)
      food_option.valid?
      expect(food_option).to be_invalid
    end
  end

  it "is valid when min is nil" do
    expect(build(:food_option, min: nil)).to be_valid
  end

  it "is valid when min is 0 or above" do
    (0..3).each do |quantity|
      expect(build(:food_option, min: quantity)).to be_valid
    end
  end

  it "is invalid when min is negative" do
    food_option = build(:food_option, min: -1)
    food_option.valid?
    expect(food_option.errors[:min]).to(
      include "must be greater than or equal to 0")
  end

  it "is valid when max is nil" do
    expect(build(:food_option, max: nil)).to be_valid
  end

  it "is valid when max is 0 or above" do
    (0..3).each do |quantity|
      expect(build(:food_option, max: quantity)).to be_valid
    end
  end

  it "is invalid when max is negative integer" do
    food_option = build(:food_option, max: -1)
    food_option.valid?
    expect(food_option.errors[:max]).to(
      include "must be greater than or equal to 0")
  end

  it "is valid when jenis is checkbox, min is not nil" do
    (0..3).each do |num|
      checkbox_option = build(:food_option,
                              jenis: Food::Option::CHECKBOXES,
                              min: num)
      expect(checkbox_option).to be_valid
    end
  end

  it "is valid when jenis is checkbox, max is nil or above 0" do
    [nil, 0, 1, 2].each do |num|
      checkbox_option = build(:food_option,
                              jenis: Food::Option::CHECKBOXES,
                              max: num)
      expect(checkbox_option).to be_valid
    end
  end

  it "is valid when min is equal to max" do
    min = 4
    expect(build(:food_option, min: min, max: min)).to be_valid
  end

  it "is invalid when min is higher than max" do
    min = 4
    incestous_option = build(:food_option, min: min, max: min - 1)
    incestous_option.valid?
    expect(incestous_option.errors[:max]).to(
      include "must be greater than or equal to #{ min }")
  end
end
