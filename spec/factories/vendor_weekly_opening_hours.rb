FactoryGirl.define do
  factory :vendor_weekly_opening_hour, :class => 'Vendor::WeeklyOpeningHour' do
    vendor_subvendor
    wday 1
    start_at 1100
    end_at 1500

    trait :all_day do
      start_at 0
      end_at 2359
    end

    factory :vendor_weekly_opening_all_day, traits: [:all_day]
  end

end
