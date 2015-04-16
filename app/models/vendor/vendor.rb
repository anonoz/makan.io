class Vendor::Vendor < ActiveRecord::Base
  acts_as_paranoid

  has_many :vendor_subvendors, class_name: "Vendor::Subvendor",
           foreign_key: "vendor_vendor_id"
  alias_method :subvendors, :vendor_subvendors
  has_many :weekly_opening_hours, class_name: "Vendor::WeeklyOpeningHour",
           through: :vendor_subvendors
  has_many :food_menus, class_name: "Food::Menu",
           through: :vendor_subvendors
  has_many :food_categories, class_name: "Food::Category",
           foreign_key: "vendor_vendor_id"
  has_many :food_options, class_name: "Food::Option",
           foreign_key: "vendor_vendor_id"
  has_many :vendor_users, class_name: "Vendor::User",
           foreign_key: "vendor_vendor_id"
  alias_method :users, :vendor_users

  validates :title, presence: true
end
