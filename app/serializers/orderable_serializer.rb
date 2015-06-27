class OrderableSerializer < ActiveModel::Serializer
  attributes :id, :type, :title, :base_price_cents, :kena_gst, :kena_delivery_fee

  def type
    object.class.to_s
  end
end
