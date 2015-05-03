require 'spec_helper'

describe Vendor::WeeklyOpeningHour do
  it "is valid with a vendor_subvendor" do
    expect(build(:vendor_weekly_opening_hour)).to be_valid
  end

  it "is invalid without a vendor_subvendor" do
    vendor_weekly_opening_hour =
      build(:vendor_weekly_opening_hour, vendor_subvendor: nil)
    vendor_weekly_opening_hour.valid?
    expect(vendor_weekly_opening_hour.errors[:vendor_subvendor]).to(
      include "can't be blank")
  end

  it "is valid with wday of sunday till saturday" do
    [:monday, :tuesday, :wednesday, :thursday, :friday, :saturday, :sunday].each do |weekday|
      expect(build(:vendor_weekly_opening_hour, wday: weekday)).to be_valid
    end
  end

  it "is invalid with wday of thorsday" do
    [:thorsday].each do |weekday|
      thorsday = build(:vendor_weekly_opening_hour, wday: weekday)
      thorsday.valid?
      expect(thorsday.errors[:wday]).to include "is not included in the list"
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
