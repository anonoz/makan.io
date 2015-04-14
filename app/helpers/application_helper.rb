module ApplicationHelper
  def weekday_string_from_integer(wday_int = 1)
    Vendor::WeeklyOpeningHour.weekdays_from_integer(wday_int)
  end
end
