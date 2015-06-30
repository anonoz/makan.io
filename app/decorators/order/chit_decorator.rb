class Order::ChitDecorator < Draper::Decorator
  delegate_all

  def mini_card_timer
    h.content_tag :div, class: "order-timer" do
      h.content_tag(:div, timer_text[:time], class: "time") +
      h.content_tag(:div, timer_text[:caption], class: "caption")
    end
  end

  def timer_text
    @object_timer_text ||= if object.status == "ordered"
      {time: time_second, caption: "secs ago"}
    else
      {time: time_minute, caption: "mins ago"}
    end
  end

  def time_second
  	seconds = (Time.now - object.state_updated_at).to_i
  	(seconds > 300) ? "MAX" : seconds
  end

  def time_minute
    minutes = ((Time.now - object.state_updated_at) / 60).to_i
    (minutes < 1) ? "< 1" : minutes
  end
end
