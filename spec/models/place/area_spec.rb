require 'spec_helper'

describe Place::Area do
  it "must belong to a city" do
    cityless_area = build(:place_area, place_city_id: nil)
    cityless_area.valid?
    expect(cityless_area.errors[:place_city]).to include "can't be blank"
  end

  it "must have a name" do
    nameless_area = build(:place_area, name: nil)
    nameless_area.valid?
    expect(nameless_area.errors[:name]).to include "can't be blank"
  end

end
