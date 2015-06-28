##
# Empty promotion handling class
#
# A promotion handling class should have these 4 attributes and 3 methods

class Promo::Base
  attr_reader :ineligibility_reasons, :unactionable_reasons, :promo_adjustments
              :explicit_ineligibility_reason
  def initialize(order_chit)
  	unless order_chit.kind_of? Order::Chit
  	  raise ArgumentError.new "Promo Handler must be initialized with order chit"
  	end

  	@order_chit = order_chit
  	@ineligibility_reasons = []
  	@unactionable_reasons = []
  	@promo_adjustments = []

  	self
  end

  def is_eligible?
    true
  end

  def is_actionable?
    true
  end

  def apply
    unless is_eligible?
      raise Promo::IneligibilityError.new ineligibility_reasons.to_sentence
    end

    unless is_actionable?
      raise Promo::ActionabilityError.new unactionable_reasons.to_sentence
    end

    @promo_adjustments
  end
end
