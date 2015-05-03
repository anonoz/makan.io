class Order::ChitSerializer < ActiveModel::Serializer
  attributes :id, :customer_user_id, :customer_address_id,
             :offline_customer_name, :offline_customer_address,
             :offline_customer_phone, :status, :remarks

  has_many :items, serializer: Order::ItemSerializer
end
