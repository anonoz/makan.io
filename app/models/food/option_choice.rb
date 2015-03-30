class Food::OptionChoice < ActiveRecord::Base
  belongs_to :food_option, class_name: "Food::Option"
  
end
