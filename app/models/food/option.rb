class Food::Option < ActiveRecord::Base
  # Jenis-jenis
  CHOOSE_MULTIPLE = 1
  CHOOSE_ONE = 2
  QUANTITIES = 3

  JENISES = {
    1 => "Choose Multiple",
    2 => "Choose One",
    3 => "Quantities"
  }

  acts_as_paranoid

  belongs_to :vendor_vendor, class_name: "Vendor::Vendor"

  has_many :choices, class_name: "Food::Option", foreign_key: "food_option_id"

  validates :title, presence: true
  validates :vendor_vendor, presence: true
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

  def self.get_options_from_jenises
    JENISES.each_pair.collect { |jenis| jenis.reverse }
  end

  def self.jenis_from_integer(jenis_int = 1)
    JENISES[jenis_int]
  end

end
