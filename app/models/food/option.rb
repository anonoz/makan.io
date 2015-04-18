class Food::Option < ActiveRecord::Base
  # kind-kind
  CHOOSE_MULTIPLE = 1
  CHOOSE_ONE = 2
  QUANTITIES = 3

  KINDS = {
    1 => "Choose Multiple",
    2 => "Choose One",
    3 => "Quantities"
  }

  acts_as_paranoid
  has_paper_trail

  belongs_to :vendor_vendor, class_name: "Vendor::Vendor"

  has_many :choices, class_name: "Food::OptionChoice", foreign_key: "food_option_id"
  has_many :food_menu_options, class_name: "Food::MenuOption", foreign_key: "food_option_id"
  has_many :food_menus, through: :food_menu_options

  validates :title, presence: true
  validates :vendor_vendor, presence: true
  validates :kind, presence: true, inclusion: { in: [1, 2, 3] }
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

  def self.get_kind_options
    KINDS.each_pair.collect { |kind| kind.reverse }
  end

  def self.food_option_kind_string(kind_id = 1)
    KINDS[kind_id]
  end

end
