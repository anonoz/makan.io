FactoryGirl.define do
  factory :vendor_user, :class => 'Vendor::User' do
    email "anonoz@makan.io"
    password "iknowright"
    password_confirmation "iknowright"
    name "Anonoz Chong"
    phone "017-3009142"
  end

end
