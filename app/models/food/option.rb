class Food::Option < ActiveRecord::Base
  # Jenis-jenis
  CHECKBOXES = 1
  NUMBERS = 2
  RADIO_BUTTONS = 3

  belongs_to :food_menu, class_name: "Food::Menu"
  has_many :choices, class_name: "Food::Option", foreign_key: "food_option_id"

  validates :food_menu, presence: true
  validates :title, presence: true
  validates :jenis, presence: true, inclusion: { in: [1, 2, 3] }
  validates :min,
            numericality: {
              greater_than_or_equal_to: 0
            },
            allow_nil: true
  validates :max,
            numericality: {
              greater_than_or_equal_to: ->(option){ option.min || 0 }
            },
            allow_nil: true

end
