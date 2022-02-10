require 'rails_helper'
RSpec.describe "merchant search request" do
  it "finds an individual merchant by name" do
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

  it "finds an individual merchant by name(sad path) no match" do
    query = "corn"
    get "/api/v1/merchants/find?name=#{query}"

    expect(response).to be_successful
    parsed = JSON.parse(response.body, symbolize_names: true)
    expect(parsed[:data][:merchant]).to eq([])
  end

  it "finds an individual merchant by name(sad path) nil params" do

    get "/api/v1/merchants/find?"

    expect(response).to_not be_successful
    parsed = JSON.parse(response.body, symbolize_names: true)
    expect(parsed[:errors][:details]).to eq("No params.")
  end

  it "finds an individual merchant by name(sad path) blank params" do

    get "/api/v1/merchants/find?name="

    expect(response).to_not be_successful
    parsed = JSON.parse(response.body, symbolize_names: true)
    expect(parsed[:errors][:details]).to eq("Empty params.")

  end

  it "find all merchants that match the name" do
    merchant_1 = Merchant.create!(name: "Billy's Pet Rocks")
    merchant_2 = Merchant.create!(name: "rock and Roll McDonalds")

    query = "rock"
    get "/api/v1/merchants/find_all?name=#{query}"

    expect(response).to be_successful

    parsed = JSON.parse(response.body, symbolize_names: true)

    expect(parsed[:data].count).to eq(2)
    parsed[:data].each do |merchant|
      expect(merchant[:type]).to eq("merchant")
    end
  end
end