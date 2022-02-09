require 'rails_helper'
RSpec.describe "items merchant request" do
  let!(:merchant_1) {Merchant.create!(name: 'Billys Pet Rocks')}
  let!(:item_1) {merchant_1.items.create!(name: 'Obsidian Nobice', description: 'A beautiful obsidian', unit_price: 50)}

  it "get an items merchant" do
    get "/api/v1/items/#{item_1.id}/merchant"

    expect(response).to be_successful

    merchant = JSON.parse(response.body, symbolize_names: true)

    expect(merchant[:data][:id]).to eq(merchant_1.id.to_s)
    expect(merchant[:data][:type]).to eq("merchant")
    expect(merchant[:data][:attributes][:name]).to eq(merchant_1.name)
  end

  it "get an items merchant(sad path)" do
    get "/api/v1/items/20/merchant"

    expect(response).to_not be_successful

    fail_response = JSON.parse(response.body, symbolize_names: true)

    expect(fail_response[:errors][:details]).to eq("Item with id of 20 does not exist.")
  end
end