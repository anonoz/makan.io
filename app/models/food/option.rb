class Food::Option < ActiveRecord::Base
  extend Enumerize
  acts_as_paranoid
  has_paper_trail

  enumerize :kind, in: {choose_multiple: 1, choose_one: 2, quantities: 3},
            default: :choose_multiple

  belongs_to :vendor_vendor, class_name: "Vendor::Vendor"

  has_many :food_option_choices, class_name: "Food::OptionChoice", foreign_key: "food_option_id"
  alias_method :choices, :food_option_choices
  has_many :food_menu_options, class_name: "Food::MenuOption", foreign_key: "food_option_id"
  has_many :food_menus, through: :food_menu_options

  validates :title, presence: true
  validates :vendor_vendor, presence: true
  validates :kind, presence: true, inclusion: {
    in: %w(choose_multiple choose_one quantities)
  }
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
