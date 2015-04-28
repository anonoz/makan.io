class Order::Item < ActiveRecord::Base
  acts_as_paranoid

  after_save :check_if_quantity_zero_then_delete

  belongs_to :order_chit, class_name: "Order::Chit"
  belongs_to :food_menu, class_name: "Food::Menu"
  has_many :extras, class_name: "Order::ItemExtra", foreign_key: "order_item_id"

  accepts_nested_attributes_for :extras

  validates :order_chit, presence: true
  validates :food_menu, presence: true

  # delegate :kena_gst?, :kena_delivery_fee?, to: :food_menu

  def amount
    set_correct_version_of_food_menu

    cost = @food_menu.base_price + (extras.collect(&:amount).reduce(:+) || 0)
    delivery_fee = @food_menu.kena_delivery_fee? ? cost * 0.1 : 0
    gst = @food_menu.kena_gst? ? cost * 0.06 : 0

    cost + delivery_fee + gst
  end

  private

  def check_if_quantity_zero_then_delete
    destroy if quantity <= 0
  end

  def set_correct_version_of_food_menu
    @food_menu = food_menu.version_at(created_at)
  end
end
