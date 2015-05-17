class Order::ItemExtra < ActiveRecord::Base
  belongs_to :order_item, class_name: "Order::Item"
  belongs_to :food_option_choice, class_name: "Food::OptionChoice"

  validates :food_option_choice, presence: true
  validates :quantity, numericality: {
    greater_than_or_equal_to: 0
  }

  after_save :update_subtotal
  after_destroy :update_subtotal
  before_update :editable?

  def amount
    set_food_option_choice_correct_version
    quantity * @choice.unit_amount
  end

  def update_subtotal
    order_item && order_item.update_subtotal
  end

  def editable?
    order_item.editable?
  end

  private

  def set_food_option_choice_correct_version
    @choice = food_option_choice.version_at(created_at)
  end
end
