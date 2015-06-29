##
# Example of a passively called promo

class Promo::StudentDeliveryFeeWaiver < Promo::Base

  ##
  # Kami kena check pelajar tu ke pelajar kan?

  def is_eligible?
    if @order_chit.from_web?
      check_customer_user_student_status
    else
      check_order_by_student
    end

    super
  end

  ##
  # For this promo to be actionable, one of the items must have delivery fee on it

  def is_actionable?
    check_order_chit_has_delivery_charges

    super
  end

  ##
  # Calculate the adjustment and add it to order_chit

  def apply(usage: Promo::Usage.new)
    check_eligibility_and_actionability

  	delivery_fee_waiver = @order_chit.items.collect(&:total_delivery_fee).reduce(:+)

    @promo_adjustments << Promo::Adjustment.new(
      title: "Student Delivery Fee Waiver",
      amount: -delivery_fee_waiver,
      promo_type: self.class.name,
      usage: usage
    )
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
