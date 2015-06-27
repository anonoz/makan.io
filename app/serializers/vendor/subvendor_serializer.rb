class Vendor::SubvendorSerializer < ActiveModel::Serializer
  attributes :id, :title

  def self.list(items = [])
    ActiveModel::ArraySerializer.new(items)
  end
end
