class Place::City < ActiveRecord::Base
  acts_as_paranoid

  has_many :vendor_subvendors, class_name: "Vendor::Subvendor",
           foreign_key: "place_city_id"
  alias_method :subvendors, :vendor_subvendors
  has_many :areas, class_name: "Place::Area",
           foreign_key: "place_city_id"
  
  validates :name, presence: true
end
