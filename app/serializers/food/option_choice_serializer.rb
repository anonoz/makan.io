class Food::OptionChoiceSerializer < ActiveModel::Serializer
  attributes :id, :title, :unit_amount_cents, :price

  def price
    object.unit_amount.format
  end
end
