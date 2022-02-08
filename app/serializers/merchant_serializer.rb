class MerchantSerializer
  include JSONAPI::Serializer
  set_type :merchant
  set_id :id
  attributes :name, :created_at, :updated_at
  # has_many :items
end
