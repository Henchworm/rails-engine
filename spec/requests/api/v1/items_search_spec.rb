require 'rails_helper'
RSpec.describe "items search" do
  let!(:merchant_1) {Merchant.create!(name: 'Billys Pet Rocks')}

  let!(:item_1) {merchant_1.items.create!(name: 'Obsidian Nobice', description: 'A beautiful obsidian', unit_price: 50)}
  let!(:item_2) {merchant_1.items.create!(name: 'Green Obsidian Cup', description: 'An obsidian cup', unit_price: 100)}
  let!(:item_3) {merchant_1.items.create!(name: 'Dirt', description: 'dirt', unit_price: 10)}

  describe "search by name" do
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

      expect(response).to be_successful
      parsed = JSON.parse(response.body, symbolize_names: true)
        expect(parsed[:data][:id]).to be_a(String)
        expect(parsed[:data][:type]).to eq("item")
        expect(parsed[:data][:attributes][:name]).to eq("Obsidian Nobice")
        expect(parsed[:data][:attributes][:merchant_id]).to eq(merchant_1.id)
    end

    it "finds one item by name(sad path no record) and returns empty array" do
      query = "Jesus Candles"
      get "/api/v1/items/find?name=#{query}"

      expect(response).to be_successful
      parsed = JSON.parse(response.body, symbolize_names: true)
    end

    it "finds  one item by name(sad path) blank params" do
      get "/api/v1/items/find?name="

      expect(response).to_not be_successful
      parsed = JSON.parse(response.body, symbolize_names: true)
      expect(parsed[:errors][:details]).to eq("Empty params.")
    end

    it "finds one item by name(sad path) no params" do
      get "/api/v1/items/find?"

      expect(response).to_not be_successful
      parsed = JSON.parse(response.body, symbolize_names: true)
      expect(parsed[:errors][:details]).to eq("No params.")
    end

    it "finds all items by name(sad path) blank params" do
      get "/api/v1/items/find_all?name="

      expect(response).to_not be_successful
      parsed = JSON.parse(response.body, symbolize_names: true)
      expect(parsed[:errors][:details]).to eq("Empty params.")
    end

    it "finds all items  by name(sad path) no params" do
      get "/api/v1/items/find_all?"

      expect(response).to_not be_successful
      parsed = JSON.parse(response.body, symbolize_names: true)
      expect(parsed[:errors][:details]).to eq("No params.")
    end
  end

  describe "search by price" do
    it "finds the alphabetical first item min price" do
      query = 50
      get "/api/v1/items/find?min_price=#{query}"
      expect(response).to be_successful
      parsed = JSON.parse(response.body, symbolize_names: true)
      expect(parsed[:data][:attributes][:name]).to eq("Green Obsidian Cup")
      expect(parsed[:data][:attributes][:unit_price]).to eq(100)
      expect(parsed[:data][:type]).to eq("item")
    end

    it "finds the alphabetical first item by max price" do
      query = 60
      get "/api/v1/items/find?max_price=#{query}"
      expect(response).to be_successful
      parsed = JSON.parse(response.body, symbolize_names: true)
      expect(parsed[:data][:attributes][:name]).to eq("Dirt")
      expect(parsed[:data][:attributes][:unit_price]).to eq(10.0)
      expect(parsed[:data][:type]).to eq("item")
    end

    it "finds the alphabetical first item by max price(sad path) max price blank" do
      get "/api/v1/items/find?max_price=#{""}"
      expect(response).to_not be_successful
      parsed = JSON.parse(response.body, symbolize_names: true)
      expect(parsed[:errors][:details]).to eq("No params.")
    end

    it "finds one item by min_price(sad path no record) and returns empty array" do
      get "/api/v1/items/find?min_price=1000"
      expect(response).to_not be_successful
      parsed = JSON.parse(response.body, symbolize_names: true)
      expect(parsed[:data][:item]).to eq([])
    end

    it "finds one item by max_price(sad path no record) and returns empty array" do
      get "/api/v1/items/find?max_price=1"
      expect(response).to_not be_successful
      parsed = JSON.parse(response.body, symbolize_names: true)
      expect(parsed[:data][:item]).to eq([])
    end


    it "finds the alphabetical first item by max price(sad path) max price nil" do
      get "/api/v1/items/find?max_price=#{nil}"
      expect(response).to_not be_successful
      parsed = JSON.parse(response.body, symbolize_names: true)
      expect(parsed[:errors][:details]).to eq("No params.")
    end

    it "finds the alphabetical first item by min price(sad path) min price blank" do
      get "/api/v1/items/find?min_price=#{""}"
      expect(response).to_not be_successful
      parsed = JSON.parse(response.body, symbolize_names: true)
      expect(parsed[:errors][:details]).to eq("No params.")
    end

    it "finds the alphabetical first item by min price(sad path) min price nil" do
      get "/api/v1/items/find?min_price=#{nil}"
      expect(response).to_not be_successful
      parsed = JSON.parse(response.body, symbolize_names: true)
      expect(parsed[:errors][:details]).to eq("No params.")
    end

    it "finds the alphabetical first item by max price(sad path)min_price less than 0 " do
      query = -5
      get "/api/v1/items/find?min_price=#{query}"
      expect(response).to_not be_successful
      parsed = JSON.parse(response.body, symbolize_names: true)
      expect(parsed[:error][:error]).to eq("Price cannot be less than 0.")
    end

    it "finds the alphabetical first item by max price(sad path)max_price less than 0 " do
      query = -5
      get "/api/v1/items/find?max_price=#{query}"
      expect(response).to_not be_successful
      parsed = JSON.parse(response.body, symbolize_names: true)
      expect(parsed[:error][:error]).to eq("Price cannot be less than 0.")
    end

    it "sad path, max price less than min" do
      get "/api/v1/items/find?max_price=5.00&min_price=10.00"
      expect(response).to_not be_successful
      parsed = JSON.parse(response.body, symbolize_names: true)
      expect(parsed[:errors][:error]).to eq("Min price cannot be less than max price.")
    end

    it "sad path, name and min price both included" do
      get "/api/v1/items/find?name=spoon&min_price=10.00"
      expect(response).to_not be_successful
      parsed = JSON.parse(response.body, symbolize_names: true)
      expect(parsed[:errors][:details]).to eq("Too many params.")
    end

    it "sad path, name and max price both included" do
      get "/api/v1/items/find?name=spoon&max_price=10.00"
      expect(response).to_not be_successful
      parsed = JSON.parse(response.body, symbolize_names: true)
      expect(parsed[:errors][:details]).to eq("Too many params.")
    end
  end
end
