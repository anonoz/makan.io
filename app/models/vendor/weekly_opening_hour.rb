class Vendor::WeeklyOpeningHour < ActiveRecord::Base
  extend Enumerize
  acts_as_paranoid

  enumerize :wday, in: {
    :sunday => 0,
    :monday => 1,
    :tuesday => 2,
    :wednesday => 3,
    :thursday => 4,
    :friday => 5,
    :saturday => 6
  }
  
  belongs_to :vendor_subvendor, class_name: "Vendor::Subvendor"

  validates :vendor_subvendor, presence: true
  validates :wday, presence: true
  validates :start_at,
            numericality: {
              greater_than_or_equal_to: 0,
              less_than_or_equal_to: 2359
            },
            minutes_in_twenty_four_hours: true
  validates :end_at,
            numericality: {
              greater_than: ->(opening_hour){ opening_hour.start_at },
              less_than_or_equal_to: 2359
            },
            minutes_in_twenty_four_hours: true

  default_scope { order(wday: :asc, start_at: :asc) }
end
