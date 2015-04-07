require 'spec_helper'

RSpec.describe Food::Category do
  it "is invalid without a title" do
    titleless_cat = build(:food_category, title: nil)
    titleless_cat.valid?
    expect(titleless_cat.errors[:title]).to include "can't be blank"
  end

  it "is valid with a vendor and a name" do
    expect(build(:food_category)).to be_valid
  end
end
