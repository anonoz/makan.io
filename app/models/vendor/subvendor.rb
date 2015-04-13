class Vendor::Subvendor < ActiveRecord::Base
  acts_as_paranoid
  
  belongs_to :vendor_vendor, class_name: "Vendor::Vendor"
  belongs_to :place_city, class_name: "Place::City"

  has_many :food_menus, class_name: "Food::Menu",
           foreign_key: "vendor_subvendor_id"
  has_many :weekly_opening_hours, class_name: "Vendor::WeeklyOpeningHour",
           foreign_key: "vendor_subvendor_id"

  validates :vendor_vendor, presence: true
  validates :place_city, presence: true
end
