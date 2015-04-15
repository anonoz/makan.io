class Vendor::WeeklyOpeningHour < ActiveRecord::Base
  WEEKDAYS = {
    1 => "Monday",
    2 => "Tuesday",
    3 => "Wednesday",
    4 => "Thursday",
    5 => "Friday",
    6 => "Saturday",
    7 => "Sunday"
  }

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

  default_scope { order(wday: :asc, start_at: :asc) }

  def self.get_options_of_weekdays
    WEEKDAYS.each_pair.collect {|day| day.reverse}
  end

  def self.weekdays_from_integer(wday_int = 1)
    WEEKDAYS[wday_int]
  end
end
