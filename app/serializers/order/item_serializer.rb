class Order::ItemSerializer < ActiveModel::Serializer
  attributes :id, :quantity, :remarks, :food_menu

  has_many :extras, each_serializer: Order::ExtraSerializer

  def food_menu
    Food::MenuSerializer.new(object.food_menu, root: false)
  end
end
