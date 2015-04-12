class Place::Area < ActiveRecord::Base
  acts_as_paranoid
  
  belongs_to :place_city, class_name: "Place::City"
  
  validates :place_city, presence: true
  validates :name, presence: true
end
