FactoryGirl.define do
  factory :vendor_subvendor, :class => 'Vendor::Subvendor' do
    association :vendor_vendor
    association :place_city
    title "Ah Beng Nasi Lemak"
  end

end
