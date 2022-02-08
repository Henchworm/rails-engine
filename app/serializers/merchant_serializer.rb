class MerchantSerializer
  include JSONAPI::Serializer
  # has_many :items
  set_type :merchant
  set_id :id
  attributes :name, :created_at, :updated_at
end
