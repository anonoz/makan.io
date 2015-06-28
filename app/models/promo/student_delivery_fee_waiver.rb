##
# Example of a passively called promo

class Promo::StudentDeliveryFeeWaiver
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

  ##
  # Kami kena check pelajar tu ke pelajar kan?

  def is_eligible?
    if @order_chit.from_web?
      check_customer_user_student_status
    else
      check_order_by_student
    end

    @ineligibility_reasons.empty?
  end

  ##
  # For this promo to be actionable, one of the items must have delivery fee on it

  def is_actionable?
    check_order_chit_has_delivery_charges

    @unactionable_reasons.empty?
  end

  ##
  # Calculate the adjustment and add it to order_chit

  def apply(usage: Promo::Usage.new)
    unless is_eligible?
      raise Promo::IneligibilityError.new ineligibility_reasons.to_sentence
    end

    unless is_actionable?
      raise Promo::ActionabilityError.new unactionable_reasons.to_sentence
    end

  	delivery_fee_waiver = @order_chit.items.collect(&:total_delivery_fee).reduce(:+)
  	# @promo_adjustments << {title: "Student Delivery Fee Waiver",amount: - delivery_fee_waiver}

    @promo_adjustments << Promo::Adjustment.new(
      title: "Student Delivery Fee Waiver",
      amount: -delivery_fee_waiver,
      promo_type: self.class.name,
      usage: usage
    )

  	@promo_adjustments
  end

  private

  def check_customer_user_student_status
    unless @order_chit.customer_user.student?
      @ineligibility_reasons << "customer user not a student"
    end
  end

  def check_order_by_student
    unless @order_chit.caller_is_student?
      @ineligibility_reasons << "caller not a student"
    end
  end

  def check_order_chit_has_delivery_charges
    unless @order_chit.items.any?(&:kena_delivery_fee?)
      @unactionable_reasons << "no item has delivery fee"
    end
  end
end
