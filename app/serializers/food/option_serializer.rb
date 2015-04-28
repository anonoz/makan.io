class Food::OptionSerializer < ActiveModel::Serializer
  attributes :id, :title, :kind, :min, :max

  has_many :choices, serializer: Food::OptionChoiceSerializer
end
