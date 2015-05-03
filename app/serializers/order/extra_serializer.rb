class Order::ExtraSerializer < ActiveModel::Serializer
  attributes :id, :food_option_choice_id, :quantity
end
