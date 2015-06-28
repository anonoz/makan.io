##
# This serves as the bridge betwene

class Promo::Chain
  attr_reader :promo_adjustments

  PROMO_CLASSES = %W(
  	Promo::Base
    Promo::StudentDeliveryFeeWaiver
  )

  def initialize(order_chit)
    unless order_chit.kind_of? Order::Chit
      raise ArgumentError.new "Promo Chain only takes in instance of Order::Chit"
    end

    @order_chit = order_chit
    @previous_usages = order_chit.promo_usages
    @promo_adjustments = []
    self
  end

  def execute
    PROMO_CLASSES.each do |promo_class|
      promo_instance = promo_class.constantize.new(@order_chit)
      promo_previous_use = @previous_usages.find_by(promo_type: promo_class)

      if promo_instance.is_eligible? && promo_instance.is_actionable?
        @promo_adjustments += promo_instance.apply

      elsif promo_previous_use.present?
        @promo_adjustments << promo_previous_use.to_adjustment(revoke: true)

      end
    end

    @promo_adjustments
  end
end
