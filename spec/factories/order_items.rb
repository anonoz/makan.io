FactoryGirl.define do
  factory :order_item, :class => 'Order::Item' do
    order_chit
    association :orderable, factory: :food_menu 
    quantity 1

    trait :custom_item do
      association :orderable, factory: :order_custom_item
    end

    factory :order_item_with_custom_item, traits: [:custom_item]
  end

end
