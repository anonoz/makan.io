FactoryGirl.define do
  factory :order_item, :class => 'Order::Item' do
    order_chit
    food_menu
    quantity 1
  end

end
