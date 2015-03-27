class Place::Area < ActiveRecord::Base
  belongs_to :place_city, class_name: "Place::City"
  
  validates :place_city, presence: true
  validates :name, presence: true
end
