class Vendor::Subvendor < ActiveRecord::Base
  acts_as_paranoid
  
  belongs_to :vendor_vendor, class_name: "Vendor::Vendor"

  has_many :food_menus, class_name: "Food::Menu",
           foreign_key: "vendor_subvendor_id"

  validates :vendor_vendor, presence: true
end
