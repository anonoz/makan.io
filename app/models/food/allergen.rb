class Food::Allergen < ActiveRecord::Base
  acts_as_paranoid

  belongs_to :vendor_vendor, class_name: "Vendor::Vendor"
  has_many :food_allergy_tags, class_name: "Food::AllergyTag",
           foreign_key: "food_allergen_id"
  has_many :food_menus,
           through: :food_allergy_tags

  validates :title, presence: true
  validates :vendor_vendor, presence: true
end
