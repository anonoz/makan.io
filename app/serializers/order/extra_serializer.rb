class Order::ExtraSerializer < ActiveModel::Serializer
  attributes :id, :food_option_choice_id, :food_option_choice, :quantity

  def food_menu
    Food::OptionChoiceSerializer.new(object.food_option_choice, root: false)
  end
end
