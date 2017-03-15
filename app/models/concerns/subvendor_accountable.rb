module SubvendorAccountable
  def order_items(from: Time.at(0), to: Date.today.end_of_day)
    if String === to
      to = if /^\d{4}-\d{2}-\d{2}$/.match(to)
        Date.parse(to).end_of_day
      else
        Time.zone.parse(to)
      end
    end

    order_chit_ids = vendor.order_chits.
      where(status: [:accepted, :delivered, :finished], created_at: from..to).
      pluck(:id)
    food_menu_ids = food_menus.pluck(:id)
    
    Order::Item.
      where(order_chit_id: order_chit_ids, orderable: food_menus)
  end

  def order_items_on(date)
    date = Date.parse(date) if String === date
    order_items(from: date.beginning_of_day, to: date.end_of_day)
  end

  def items_ordered(date_range = {})
    order_items(date_range).sum(:quantity) || 0
  end

  def items_ordered_on(date)
    date = Date.parse(date) if String === date
    items_ordered(from: date.beginning_of_day, to: date.end_of_day)
  end

  def amount_payable(date_range = {})
    order_items(date_range).collect(&:subvendor_payable).reduce(:+) || 0.to_money
  end

  def amount_payable_on(date)
    date = Date.parse(date) if String === date
    amount_payable(from: date.beginning_of_day, to: date.end_of_day)
  end
end
