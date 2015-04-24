require 'spec_helper'

describe Place::Area do
  it "is valid if belong to a city" do
    cityless_area = build(:place_area, city: nil)
    cityless_area.valid?
    expect(cityless_area.errors[:city]).to include "can't be blank"
  end

  it "is valid if have a name" do
    nameless_area = build(:place_area, name: nil)
    nameless_area.valid?
    expect(nameless_area.errors[:name]).to include "can't be blank"
  end

  it "is valid if its in Setapak" do
    expect(build(:place_area, city: :setapak)).to be_valid
    expect(build(:place_area, city: "setapak")).to be_valid
  end

  it "is invalid if its in unlisted cities such as Penang" do
    georgetown = build(:place_area, city: :penang)
    georgetown.valid?
    expect(georgetown.errors[:city]).to include "is not included in the list"
  end

end
