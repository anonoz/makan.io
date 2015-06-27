FactoryGirl.define do
  factory :order_chit, :class => 'Order::Chit' do
    vendor_vendor
    customer_user
    customer_address
    remarks ""

    trait :offline_guest do
      from_web false
      customer_user nil
      customer_address nil
      offline_customer_name "Ah Beng"
      offline_customer_address "123, PV10"
      offline_customer_phone "012-1324567"
    end

    factory :order_chit_for_offline_guest, traits: [:offline_guest]
  end

end
