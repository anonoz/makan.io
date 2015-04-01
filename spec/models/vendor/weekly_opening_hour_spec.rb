require 'spec_helper'

describe Vendor::WeeklyOpeningHour do
  it "is valid with a vendor_vendor" do
    expect(build(:vendor_weekly_opening_hour)).to be_valid
  end

  it "is invalid without a vendor_vendor" do
    vendor_weekly_opening_hour =
      build(:vendor_weekly_opening_hour, vendor_vendor: nil)
    vendor_weekly_opening_hour.valid?
    expect(vendor_weekly_opening_hour.errors[:vendor_vendor]).to(
      include "can't be blank")
  end

  it "is valid with wday of 1 to 7" do
    (1..7).each do |day|
      expect(build(:vendor_weekly_opening_hour, wday: day)).to be_valid
    end
  end

  it "is invalid with wday of 0 and lower" do
    (-1..0).each do |day|
      vendor_weekly_opening_hour =
        build(:vendor_weekly_opening_hour, wday: day)
      vendor_weekly_opening_hour.valid?
      expect(vendor_weekly_opening_hour.errors[:wday]).to(
        include "must be greater than or equal to 1")
    end
  end

  it "is invalid with wday of above 7" do
    (8..9).each do |day|
      vendor_weekly_opening_hour =
        build(:vendor_weekly_opening_hour, wday: day)
      vendor_weekly_opening_hour.valid?
      expect(vendor_weekly_opening_hour.errors[:wday]).to(
        include "must be less than or equal to 7")
    end
  end

  it "is valid with start_at of 0000 to 2358 and end_at more than it" do
    test_target_times = [0, 630, 1245, 1640, 2358]
    test_target_times.each do |time|
      vendor_weekly_opening_hour =
        build(:vendor_weekly_opening_hour, start_at: time, end_at: time+1)
      expect(vendor_weekly_opening_hour).to be_valid
    end
  end

  it "is invalid with start_at of less than 0" do
    vendor_weekly_opening_hour =
      build(:vendor_weekly_opening_hour, start_at: -1)
    vendor_weekly_opening_hour.valid?
    expect(vendor_weekly_opening_hour.errors[:start_at]).to(
      include "must be greater than or equal to 0")
  end

  it "is invalid with start_at of 2400 and above" do
    [2400, 2401].each do |time|
      vendor_weekly_opening_hour =
        build(:vendor_weekly_opening_hour, start_at: time)
      vendor_weekly_opening_hour.valid?
      expect(vendor_weekly_opening_hour.errors[:start_at]).to(
        include "must be less than or equal to 2359")
    end
  end

  it "is invalid with start_at with minutes of more than 59" do
    [60, 1270, 1680, 2360].each do |time|
      vendor_weekly_opening_hour =
        build(:vendor_weekly_opening_hour, start_at: time)
      vendor_weekly_opening_hour.valid?
      expect(vendor_weekly_opening_hour.errors[:start_at]).to(
        include "minutes can't be more than 59")
    end
  end

  it "is invalid with end_at earlier than start_at" do
    start_at = 1200
    vendor_weekly_opening_hour =
      build(:vendor_weekly_opening_hour,
            start_at: start_at,
            end_at: start_at - 1)
    vendor_weekly_opening_hour.valid?
    expect(vendor_weekly_opening_hour.errors[:end_at]).to(
      include "must be greater than #{ start_at }")
  end

  it "is invalid with end_at of 2400 and above" do
    [2400, 2401].each do |time|
      vendor_weekly_opening_hour =
        build(:vendor_weekly_opening_hour, end_at: time)
      vendor_weekly_opening_hour.valid?
      expect(vendor_weekly_opening_hour.errors[:end_at]).to(
        include "must be less than or equal to 2359")
    end
  end

  it "is invalid with end_at with minutes of more than 59" do
    [60, 1270, 1680, 2360].each do |time|
      vendor_weekly_opening_hour =
        build(:vendor_weekly_opening_hour, start_at: time, end_at: time + 1)
      vendor_weekly_opening_hour.valid?
      expect(vendor_weekly_opening_hour.errors[:end_at]).to(
        include "minutes can't be more than 59")
    end
  end
end
