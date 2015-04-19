FactoryGirl.define do
  factory :vendor_user, :class => 'Vendor::User' do
    association :vendor, factory: :vendor_vendor
    email "anonoz@makan.io"
    password "iknowright"
    password_confirmation "iknowright"
    name "Anonoz Chong"
    phone "017-3009142"
    permission_level 100
  end

end
