require 'spec_helper'

describe Place::City do
  it "is valid with a name" do
    expect(build(:place_city)).to be_valid
  end

  it "is invalid without a name" do
    nameless_city = build(:place_city, name: nil)
    nameless_city.valid?
    expect(nameless_city.errors[:name]).to include("can't be blank")
  end
end
