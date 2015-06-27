class Order::ItemSerializer < ActiveModel::Serializer
  attributes :id, :quantity, :remarks, :orderable

  has_many :extras, each_serializer: Order::ExtraSerializer

  def orderable
    OrderableSerializer.new(object.orderable, root: false)
  end
end
