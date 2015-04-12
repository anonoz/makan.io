class Customer::Address < ActiveRecord::Base
  acts_as_paranoid
  
  belongs_to :customer_user, class_name: "Customer::User"
  belongs_to :place_area, class_name: "Place::Area"

  validates :customer_user, presence: true
  validates :place_area, presence: true
  validates :address, presence: true
end
