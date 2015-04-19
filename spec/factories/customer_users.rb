FactoryGirl.define do
  factory :customer_user, :class => 'Customer::User' do
    email { Faker::Internet.email }
    password "iknowright"
    password_confirmation "iknowright"
    name "Anonoz Chong"
    phone "017-3009142"
  end

end
