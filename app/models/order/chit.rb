class Order::Chit < ActiveRecord::Base
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
  has_many :items, class_name: "Order::Item", foreign_key: "order_chit_id"

  accepts_nested_attributes_for :items, reject_if: proc { |attrs| 
    attrs["food_menu_id"].blank?
  }, allow_destroy: true

  aasm column: :status, no_direct_assignment: true do
    state :draft
    state :ordered, initial: true
    state :rejected
    state :accepted
    state :delivered

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
  end

  validates :vendor_vendor, presence: true

  before_update :check_if_delivered

  def delivery_destination_info
    if customer_user.present? && customer_address.present?
      {
        web: true,
        name: customer_user.name,
        address: customer_address.human_readable,
        phone: customer_user.phone
      }
    else
      {
        web: false,
        name: offline_customer_name,
        address: offline_customer_address,
        phone: offline_customer_phone
      }
    end
  end

  def calculate_subtotal
    items.collect(&:amount).reduce(:+) || 0
  end

  def update_subtotal
    update subtotal: calculate_subtotal
  end

  private

  def check_if_delivered
    status_changed? || !delivered?
  end
end
