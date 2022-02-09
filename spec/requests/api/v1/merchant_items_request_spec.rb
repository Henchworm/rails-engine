require 'rails_helper'
RSpec.describe "merchant items request spec" do
  let!(:merchant_1) {Merchant.create!(name: 'Billys Pet Rocks')}

  let!(:item_1) {merchant_1.items.create!(name: 'Obsidian Nobice', description: 'A beautiful obsidian', unit_price: 50)}
  let!(:item_2) {merchant_1.items.create!(name: 'Pleasure Geode', description: 'Glamourous Geode', unit_price: 100)}

  it "returns all items associated with one merchant" do
    get "/api/v1/merchants/#{merchant_1.id}/items"

        expect(response).to be_successful

        items = JSON.parse(response.body, symbolize_names: true)

        expect(items[:data].count).to eq(2)

        items[:data].each do |item|
         expect(item).to have_key(:id)
         expect(item[:id]).to be_a(String)

         expect(item).to have_key(:type)
         expect(item[:type]).to eq("item")

         expect(item[:attributes]).to have_key(:name)
         expect(item[:attributes][:name]).to be_a(String)

         expect(item[:attributes]).to have_key(:description)
         expect(item[:attributes][:description]).to be_a(String)

         expect(item[:attributes]).to have_key(:unit_price)
         expect(item[:attributes][:unit_price]).to be_a(Float)

         expect(item[:attributes]).to have_key(:merchant_id)
         expect(item[:attributes][:merchant_id]).to be_an(Integer)

       end


  end
end