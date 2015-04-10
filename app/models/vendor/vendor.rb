class Vendor::Vendor < ActiveRecord::Base
  validates :title, presence: true

  has_many :vendor_subvendors, class_name: "Vendor::Subvendor",
           foreign_key: "vendor_vendor_id"
  has_many :food_menus, class_name: "Food::Menu",
           through: :vendor_subvendors
end
