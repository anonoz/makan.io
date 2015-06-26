class Order::Item < ActiveRecord::Base
  acts_as_paranoid

  after_save :check_if_quantity_zero_then_delete, :update_subtotal
  after_destroy :update_subtotal
  before_update :editable?

  belongs_to :order_chit, class_name: "Order::Chit"
  belongs_to :orderable, -> { with_deleted }, polymorphic: true

  has_many :extras, class_name: "Order::ItemExtra",
           foreign_key: "order_item_id",
           after_remove: :update_subtotal

  accepts_nested_attributes_for :extras

  validates :orderable, presence: true

  delegate :title, :base_price,
           to: :set_orderable

  def amount
    quantity * (cost + delivery_fee + gst)
  end

  def cost
    @cost = set_orderable.base_price + (extras.reload.collect(&:amount).reduce(:+) || 0)
  end

  def delivery_fee
    set_orderable.kena_delivery_fee ? cost * 0.1 : 0
  end

  def gst
    set_orderable.kena_gst ? cost * 0.06 : 0
  end

  def subvendor_payable
    quantity * set_orderable.subvendor_price
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
