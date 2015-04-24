class Place::Area < ActiveRecord::Base
  extend Enumerize
  enumerize :city, in: {setapak: 1}, default: :setapak, scope: :in_city

  acts_as_paranoid
  
  validates :name, presence: true
  validates :city, presence: true
end
