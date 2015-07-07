class Food::Category < ActiveRecord::Base
  acts_as_paranoid
  has_paper_trail

  before_destroy :check_if_no_food_menus

  has_many :food_menus, class_name: "Food::Menu",
           foreign_key: "food_category_id"
  
  validates :title, presence: true

  def to_s
    title
  end

  def check_if_no_food_menus
    unless food_menus.empty?
      errors.add :base, "still has food menus"
      return false
    end
  end
end
