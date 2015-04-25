class Order::Item < ActiveRecord::Base
  acts_as_paranoid

  after_save :check_if_quantity_zero_then_delete

  belongs_to :order_chit, class_name: "Order::Chit"
  belongs_to :food_menu, class_name: "Food::Menu"

  validates :order_chit, presence: true
  validates :food_menu, presence: true

  private

  def check_if_quantity_zero_then_delete
    destroy if quantity <= 0
  end
end
