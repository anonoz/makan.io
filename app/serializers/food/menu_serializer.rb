class Food::MenuSerializer < ActiveModel::Serializer
  attributes :id, :title, :base_price_cents, :halal, :kena_gst,
             :kena_delivery_fee, :availability, :feature_photo

  has_many :food_options
end
