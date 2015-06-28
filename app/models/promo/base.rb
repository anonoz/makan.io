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
    check_if_xxx
    @ineligibility_reasons.empty?
  end

  def is_actionable?
    check_if_yyy
    @unactionable_reasons.empty?
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

  private

  def check_if_xxx
    @ineligibility_reasons << "this is just a promo handler base"
  end

  def check_if_yyy
    @unactionable_reasons << "this is just a promo handler base"
  end
end
