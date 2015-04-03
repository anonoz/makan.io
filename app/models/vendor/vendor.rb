class Vendor::Vendor < ActiveRecord::Base
  validates :title, presence: true

  has_many :food_menus, class_name: "Food::Menu", foreign_key: "vendor_vendor_id"
end
