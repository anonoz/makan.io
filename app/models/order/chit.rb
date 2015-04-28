class Order::Chit < ActiveRecord::Base
  extend Enumerize
  acts_as_paranoid
  has_paper_trail

  belongs_to :vendor_vendor, class_name: "Vendor::Vendor"
  alias_method :vendor, :vendor_vendor
  belongs_to :customer_user, class_name: "Customer::User"
  belongs_to :customer_address, class_name: "Customer::Address"
  has_many :items, class_name: "Order::Item", foreign_key: "order_chit_id"

  accepts_nested_attributes_for :items, reject_if: proc { |attrs| 
    attrs["food_menu_id"].blank?
  }, allow_destroy: true

  enumerize :status, in: [:draft, :ordered, :rejected, :accepted, :delivered],
            default: :draft, predicates: { prefix: true }

  validates :vendor_vendor, presence: true
end
