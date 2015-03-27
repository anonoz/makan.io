FactoryGirl.define do
  factory :customer_user, :class => 'Customer::User' do
    email "anonoz@makan.io"
    password "iknowright"
    password_confirmation "iknowright"
    name "Anonoz Chong"
    phone "017-3009142"
  end

end
