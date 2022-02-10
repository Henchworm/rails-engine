require 'rails_helper'
RSpec.describe "items search" do
  let!(:merchant_1) {Merchant.create!(name: 'Billys Pet Rocks')}

  let!(:item_1) {merchant_1.items.create!(name: 'Obsidian Nobice', description: 'A beautiful obsidian', unit_price: 50)}
  let!(:item_2) {merchant_1.items.create!(name: 'Green Obsidian Cup', description: 'An obsidian cup', unit_price: 100)}

  it "find all items that match a search" do
    query = "obsidian"
    get "/api/v1/items/find_all?name=#{query}"
    expect(response).to be_successful
    parsed = JSON.parse(response.body, symbolize_names: true)
    expect(parsed[:data].count).to eq(2)

    parsed[:data].each do |item|

      expect(item[:id]).to be_a(String)
      expect(item[:type]).to eq("item")
      expect(item[:attributes][:name].include?("Obsidian")).to eq(true)
      expect(item[:attributes][:merchant_id]).to eq(merchant_1.id)
    end
  end

  it "finds one item by name" do
    query = "Obsidian Nobice"
    get "/api/v1/items/find?name=#{query}"
  end

end
