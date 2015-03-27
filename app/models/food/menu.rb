class Food::Menu < ActiveRecord::Base
  belongs_to :food_category, class_name: "Food::Category"
  belongs_to :vendor_vendor, class_name: "Vendor::Vendor"

  validates :food_category, presence: true
  validates :vendor_vendor, presence: true
  validates :title, presence: true
  validates :base_price, presence: true, numericality: true
end
