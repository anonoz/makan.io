FactoryGirl.define do
  factory :vendor_vendor, :class => 'Vendor::Vendor' do
    title "Running Man Food Delivery"
    address "E-101-A, Jalan Cyberia 5"
    email "anonoz@makan.io"
    phone "017-3009142"
    city :setapak
  end
end
