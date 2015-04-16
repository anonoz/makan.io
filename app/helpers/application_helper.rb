module ApplicationHelper
  def weekday_string_from_integer(wday_int = 1)
    Vendor::WeeklyOpeningHour.weekdays_from_integer(wday_int)
  end

  def food_option_kind_string(kind_id = 1)
    Food::Option.food_option_kind_string(kind_id)
  end
end
