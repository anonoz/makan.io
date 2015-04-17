class Food::Category < ActiveRecord::Base
  acts_as_paranoid
  has_paper_trail
  
  validates :title, presence: true
end
