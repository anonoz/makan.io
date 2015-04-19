FactoryGirl.define do
  factory :order_chit, :class => 'Order::Chit' do
    customer_user
    customer_address
    status :draft
    remarks ""

    trait :offline_guest do
      customer_user nil
      customer_address nil
    end

    factory :order_chit_for_offline_guest, traits: [:offline_guest]
  end

end
