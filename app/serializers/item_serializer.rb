class ItemSerializer
  include JSONAPI::Serializer
  set_type :item
  set_id :id
  attributes :name, :description, :unit_price, :created_at, :updated_at, :merchant_id
end
