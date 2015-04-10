class Food::Category < ActiveRecord::Base
  validates :title, presence: true
end
