class Food::MenuOption < ActiveRecord::Base
  belongs_to :food_menu, class_name: "Food::Menu"
  belongs_to :food_option, class_name: "Food::Option"

  validates :food_menu, presence: true
  validates :food_option, presence: true
end
