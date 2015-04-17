FactoryGirl.define do
  factory :vendor_special_closing_hour, :class => 'Vendor::SpecialClosingHour' do
    vendor_subvendor
    start_at "2015-03-31 12:00:00"
    end_at "2015-03-31 15:00:00"
  end

end
