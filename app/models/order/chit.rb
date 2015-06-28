class Order::Chit < ActiveRecord::Base
  attr :promos

  extend Enumerize
  include AASM
  acts_as_paranoid
  has_paper_trail
  monetize :subtotal_cents
  self.per_page = 30

  belongs_to :vendor_vendor, class_name: "Vendor::Vendor"
  alias_method :vendor, :vendor_vendor
  belongs_to :customer_user, class_name: "Customer::User"
  belongs_to :customer_address, class_name: "Customer::Address"

  has_many :items, class_name: "Order::Item",
           foreign_key: "order_chit_id",
           after_remove: :update_subtotal
  has_many :promo_usages, class_name: "Promo::Usage",
           foreign_key: "order_chit_id"

  accepts_nested_attributes_for :items, :promo_usages, allow_destroy: true

  aasm column: :status, no_direct_assignment: true do
    state :draft
    state :ordered, initial: true
    state :rejected
    state :accepted
    state :delivered
    state :finished

    event :order do
      transitions from: :draft, to: :ordered
    end

    ##
    # Rejected order can be edited, and thus accepted later on
    event :reject do
      transitions from: :ordered, to: :rejected
    end

    ##
    # Accepted order gets sent into pending mode
    event :accept do
      transitions from: [:ordered, :rejected], to: :accepted
    end

    ##
    # Delivered order is not modifiable
    event :deliver do
      transitions from: :accepted, to: :delivered
    end

    ##
    # Serves as archive
    event :finish do
      transitions from: :delivered, to: :finished
    end
  end

  validates :vendor_vendor, presence: true

  before_update :editable?
  after_create :update_subtotal

  def delivery_destination_info
    @delivery_info ||= if from_web?
      {
        name: customer_user.name,
        address: customer_address.human_readable,
        phone: customer_user.phone
      }
    else
      {
        name: offline_customer_name,
        address: offline_customer_address,
        phone: offline_customer_phone
      }
    end
  end

  def item_total
    items.reload.collect(&:amount).reduce(:+) || 0
  end

  def promo_adjustments
    Promo::Chain.new(self).execute
  end

  def calculate_subtotal
    # If you don't put the reload there, it just loads the existing items from 
    # the cache
    # binding.remote_pry if promo_adjustments.any?
    item_total + (promo_adjustments.collect(&:amount).reduce(:+) || 0)
  end

  def update_subtotal(*args)
    update subtotal: calculate_subtotal,
           promo_usages_attributes: promo_adjustments.collect(&:usage).collect(&:attributes)
  end

  def editable?
    check_if_delivered
  end

  private

  def check_if_delivered
    status_changed? || !delivered? && !finished?
  end

end
