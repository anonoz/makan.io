FactoryGirl.define do
  factory :order_item_extra, :class => 'Order::ItemExtra' do
    order_item
    food_option_choice
    quantity 1
  end

end
