class Order::CustomItem < ActiveRecord::Base
  acts_as_paranoid
  has_paper_trail

  monetize :base_price_cents
  monetize :subvendor_price_cents

  belongs_to :vendor_subvendor, class_name: "Vendor::Subvendor"
  alias_method :subvendor, :vendor_subvendor

  has_many :order_items, as: :orderable

  validates :title, presence: true
  
end
