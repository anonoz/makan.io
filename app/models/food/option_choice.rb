class Food::OptionChoice < ActiveRecord::Base
  acts_as_paranoid
  has_paper_trail
  monetize :unit_amount_cents
  monetize :subvendor_price_cents
  
  belongs_to :food_option, class_name: "Food::Option"
  
  validates :food_option, presence: true
  validates :title, presence: true
  validates :min,
            numericality: { greater_than_or_equal_to: 0 }
  validates :max,
            numericality: { greater_than_or_equal_to: 0 }
  validates :unit_amount_cents,
            numericality: { greater_than_or_equal_to: 0 }
  validates :default_quantity,
            numericality: { greater_than_or_equal_to: 0 }

end
