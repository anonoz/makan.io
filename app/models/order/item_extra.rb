class Order::ItemExtra < ActiveRecord::Base
  belongs_to :order_item, class_name: "Order::Item"
  belongs_to :food_option_choice, class_name: "Food::OptionChoice"

  validates :order_item, presence: true
  validates :food_option_choice, presence: true
  validates :quantity, numericality: {
    greater_than_or_equal_to: 0
  }

  def amount
    quantity * food_option_choice.unit_amount
  end
end
