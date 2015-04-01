FactoryGirl.define do
  factory :vendor_weekly_opening_hour, :class => 'Vendor::WeeklyOpeningHour' do
    vendor_vendor
    wday 1
    start_at 800
    end_at 2200

    trait :all_day do
      start_at 0
      end_at 0
    end

    factory :vendor_weekly_opening_all_day, traits: [:all_day]
  end

end
