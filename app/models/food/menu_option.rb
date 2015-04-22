class Food::MenuOption < ActiveRecord::Base
  acts_as_paranoid
  
  belongs_to :food_menu, class_name: "Food::Menu"
  belongs_to :food_option, class_name: "Food::Option"

  validates :food_option, presence: true
end
