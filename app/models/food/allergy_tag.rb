class Food::AllergyTag < ActiveRecord::Base
  belongs_to :food_menu, class_name: "Food::Menu"
  belongs_to :food_allergen, class_name: "Food::Allergen"
end
