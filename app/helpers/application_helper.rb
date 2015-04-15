module ApplicationHelper
  def weekday_string_from_integer(wday_int = 1)
    Vendor::WeeklyOpeningHour.weekdays_from_integer(wday_int)
  end

  def jenis_string_from_integer(jenis_int = 1)
    Food::Option.jenis_from_integer(jenis_int)
  end
end
