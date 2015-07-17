class Order::Item < ActiveRecord::Base
  acts_as_paranoid

  after_save :check_if_quantity_zero_then_delete, :update_subtotal
  after_destroy :update_subtotal
  before_update :editable?

  belongs_to :order_chit, class_name: "Order::Chit"
  belongs_to :orderable, -> { with_deleted }, polymorphic: true
  alias_method :food_menu, :orderable

  has_many :extras, class_name: "Order::ItemExtra",
           foreign_key: "order_item_id",
           after_remove: :update_subtotal,
           dependent: :destroy

  accepts_nested_attributes_for :extras

  validates :orderable, presence: true

  delegate :title, :base_price, :total_delivery_fee, :kena_delivery_fee?,
           to: :set_orderable

  def amount
    original_cost = cost
    quantity * (original_cost + delivery_fee(original_cost) + gst(original_cost))
  end

  def cost
    @cost = set_orderable.base_price + (extras.reload.collect(&:amount).reduce(:+) || 0)
  end

  def delivery_fee(original_cost = cost)
    set_orderable.kena_delivery_fee ? original_cost * 0.1 : 0
  end

  def total_delivery_fee(original_cost = cost)
    quantity * delivery_fee(cost)
  end

  def gst(original_cost = cost)
    set_orderable.kena_gst ? original_cost * 0.06 : 0
  end

  def extras_subvendor_payable
    extras.collect(&:subvendor_payable).reduce(:+) || 0
  end

  def subvendor_payable
    quantity * set_orderable.subvendor_price + extras_subvendor_payable
  end

  def update_subtotal(*args)

    # Say an item's order chit ID is changed to nil, or another chit's ID,
    # we need to update subtotals of both order chits.
    if order_chit_id_changed?
      order_chit_id_was && Order::Chit.find(order_chit_id_was).update_subtotal
    end

    order_chit && order_chit.update_subtotal
  end

  def editable?
    order_chit.present? ? order_chit.editable? : true
  end

  def food_menu_id
    orderable_type == "Food::Menu" && orderable_id
  end

  def food_menu_id=(food_menu_id)
    self.orderable = Food::Menu.find_by_id(food_menu_id)
  end

  def custom_item_attributes= (params)
    if params[:id]
      # self.orderable = Order::CustomItem.find_by_id(params[:id])
      orderable.update(params)
    else
      self.orderable = Order::CustomItem.new(params)
    end
  end

  def wipe_from_database!
    extras.delete_all
    really_destroy!
  end

  private

  def check_if_quantity_zero_then_delete
    destroy if quantity <= 0
  end

  def set_orderable
    @orderable_item ||= if orderable.paper_trail_enabled_for_model?
      orderable.version_at(created_at || Time.now)
    else
      orderable
    end
  end

  def check_if_order_chit_delivered
    !order_chit.delivered?
  end

end
