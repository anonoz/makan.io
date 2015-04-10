class Food::MenuOption < ActiveRecord::Base
  belongs_to :food_menu
  belongs_to :food_option
end
