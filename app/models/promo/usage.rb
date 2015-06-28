class Promo::Usage < ActiveRecord::Base
  belongs_to :order_chit, class_name: "Order::Chit"

  validates :order_chit, presence: true

  acts_as_paranoid
  has_paper_trail
  monetize :adjustment_cents

  def to_adjustment(revoke: false)
    Promo::Adjustment.new(
      title: title,
      amount: adjustment,
      promo_type: promo_type.constantize,
      usage: self,
      revoke: revoke
    )
  end
end
