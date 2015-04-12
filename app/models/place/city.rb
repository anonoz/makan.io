class Place::City < ActiveRecord::Base
  acts_as_paranoid
  
  validates :name, presence: true
end
