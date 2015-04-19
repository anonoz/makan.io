require 'spec_helper'

describe Food::Allergen do
  it "is valid with title and associated vendor_vendor" do
    expect(build(:food_allergen)).to be_valid
  end

  it "is invalid without title" do
    allergen = build(:food_allergen, title: nil)
    allergen.valid?
    expect(allergen.errors[:title]).to include "can't be blank"
  end

  it "is invalid without associated vendor_vendor" do
    allergen = build(:food_allergen, vendor_vendor: nil)
    allergen.valid?
    expect(allergen.errors[:vendor_vendor]).to include "can't be blank"
  end
end
