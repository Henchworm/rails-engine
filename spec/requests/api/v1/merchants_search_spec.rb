require 'rails_helper'
RSpec.describe "merchant search request" do
  it "finds a merchant by name" do
    merchant_1 = Merchant.create!(name: "Billy's Pet Rocks")
    merchant_2 = Merchant.create!(name: "rock and Roll McDonalds")

    query = "rock"
    get "/api/v1/merchants/find?name=#{query}"

    expect(response).to be_successful
    parsed = JSON.parse(response.body, symbolize_names: true)
    expect(parsed[:data][:id]).to eq(merchant_1.id.to_s)
    expect(parsed[:data][:type]).to eq("merchant")
    expect(parsed[:data][:attributes][:name]).to eq("Billy's Pet Rocks")
  end

  it "finds a merchant by name(sad path)" do
    merchant_1 = Merchant.create!(name: "Billy's Pet Rocks")
    query = "corn"
    get "/api/v1/merchants/find?name=#{query}"

    expect(response).to be_successful
    parsed = JSON.parse(response.body, symbolize_names: true)
    expect(parsed[:errors][:data]).to eq("No merchants match your search corn")
  end
end