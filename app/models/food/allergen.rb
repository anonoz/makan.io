class Food::Allergen < ActiveRecord::Base
  acts_as_paranoid

  belongs_to :vendor_vendor, class_name: "Vendor::Vendor"

  validates :title, presence: true
  validates :vendor_vendor, presence: true
end
