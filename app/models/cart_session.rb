class CartSession
  def initialize
    session[:cart] ||= {
      :order_items => []
    }
  end

  def << (order_item)
    session[:cart][:order_items] << order_item
  end

  def total
    
  end
end