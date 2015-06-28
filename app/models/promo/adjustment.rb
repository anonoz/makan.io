##
# This is like the in-memory version of Promo::Usage, store temporary promo
# adjustments to facilitate order chit subtotal calculation.
#
# Promo::Usage is associated so that if adjustments are changed during the
# lifecycle of orderchit or promochain or whatever, promo usage will be updated
# as well.

class Promo::Adjustment
  attr :title, :amount, :promo_type, :usage

  def initialize(title: "", amount: 0, promo_type: Promo::Base, usage: Promo::Usage.new, revoke: false)
    if usage.present? && !usage.instance_of?(Promo::Usage)
      raise ArgumentError, "usage key must be instance of Promo::Usage"
    end

    @title = title
    @amount = amount
    @usage = usage
    @promo_type = promo_type
    @revoke = revoke
  end

  ##
  # This method is called on persistence
  # Had usage been persisted into DB, we will return the unsaved modified version
  # of it
  # But if the adjustment is newly introduced, we will just take the default arg
  # and put attributes inside.
  #
  # Then it's up to Order::Chit instance to push this into their promos[] collection

  def to_usage
    @usage.attributes= {title: @title, adjustment: @amount,
    	                promo_type: @promo_type.to_s}

    if @revoke
      @usage.deleted_at = Time.now
    end
    
    @usage
  end
end
