class Food::Category < ActiveRecord::Base
  belongs_to :vendor_vendor, class_name: "Vendor::Vendor"

  validates :vendor_vendor, presence: true
  validates :title, presence: true
end
