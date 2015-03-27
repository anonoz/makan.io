FactoryGirl.define do
  factory :customer_address, :class => 'Customer::Address' do
    customer_user
    place_area
    address "E-101-A, Jalan Cyberia 5"
  end

end
