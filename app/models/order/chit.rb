class Order::Chit < ActiveRecord::Base
  extend Enumerize
  acts_as_paranoid
  has_paper_trail

  belongs_to :vendor_vendor, class_name: "Vendor::Vendor"
  alias_method :vendor, :vendor_vendor
  belongs_to :customer_user, class_name: "Customer::User"
  belongs_to :customer_address, class_name: "Customer::Address"

  enumerize :status, in: [:draft, :ordered, :rejected, :accepted, :delivered],
            default: :draft, predicates: { prefix: true }

  validates :vendor_vendor, presence: true
end
