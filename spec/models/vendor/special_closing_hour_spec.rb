require 'spec_helper'

describe Vendor::SpecialClosingHour do
  it "is valid with a vendor_vendor" do
    special_closing_hour = build(:vendor_special_closing_hour)
    expect(special_closing_hour).to be_valid
  end

  it "is invalid without a vendor_vendor" do
    special_closing_hour =
      build(:vendor_special_closing_hour, vendor_vendor: nil)
    special_closing_hour.valid?
    expect(special_closing_hour.errors[:vendor_vendor]).to(
      include "can't be blank")
  end

  it "is valid with a start_at" do
    special_closing_hour = build(:vendor_special_closing_hour)
    expect(special_closing_hour).to be_valid
  end

  it "is invalid without a start_at" do
    special_closing_hour =
      build(:vendor_special_closing_hour, start_at: nil)
    special_closing_hour.valid?
    expect(special_closing_hour.errors[:start_at]).to(
      include "can't be blank")
  end

  it "is valid with a end_at" do
  	special_closing_hour = build(:vendor_special_closing_hour)
  	expect(special_closing_hour).to be_valid
  end

  it "is invalid without a end_at" do
    special_closing_hour =
      build(:vendor_special_closing_hour, end_at: nil)
    special_closing_hour.valid?
    expect(special_closing_hour.errors[:end_at]).to(
      include "can't be blank")
  end

  it "is invalid with end_at earlier than start_at" do
    special_closing_hour =
      build(:vendor_special_closing_hour, start_at: Time.now)
    special_closing_hour.end_at = 1.hour.ago
    special_closing_hour.valid?
    expect(special_closing_hour.errors[:end_at]).to(
      include "must be later than compared time")
  end
end
