module OpeningTimeable
  def normally_open?(time = Time.now)
    hourmin = time.hour * 100 + time.min
    weekly_opening_hours.where("wday = ? AND start_at <= ? AND end_at >= ?",
                               time.wday, hourmin, hourmin).any?
  end

  def normally_closed?(time = Time.now)
    !normally_open?(time)
  end

  def specially_closed?(time = Time.now)
    special_closing_hours.where("start_at <= ? and end_at >= ?", time, time).
                          any?
  end

  def open?(time = Time.now)
    normally_open?(time) && !specially_closed?(time)
  end

  def closed?(time = Time.now)
    !open?(time)
  end
end
