class Vendor::WeeklyOpeningHour < ActiveRecord::Base
  acts_as_paranoid
  
  belongs_to :vendor_subvendor, class_name: "Vendor::Subvendor"

  validates :vendor_subvendor, presence: true
  validates :wday,
            numericality: {
              greater_than_or_equal_to: 1,
              less_than_or_equal_to: 7
            }
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

end
