class Food::MenuSerializer < ActiveModel::Serializer
  attributes :id, :title, :base_price_cents, :halal, :kena_gst,
             :kena_delivery_fee, :availability, :feature_photo,
             :available

  has_many :food_options

  def available
    object.available?
  end
end
