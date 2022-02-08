require 'rails_helper'
RSpec.describe "Items API" do
  let!(:merchant_1) {Merchant.create!(name: 'Billys Pet Rocks')}
  let!(:merchant_2) {Merchant.create!(name: 'Rons Trumpets')}

  let!(:item_1) {merchant_1.items.create!(name: 'Obsidian Nobice', description: 'A beautiful obsidian', unit_price: 50)}
  let!(:item_2) {merchant_1.items.create!(name: 'Pleasure Geode', description: 'Glamourous Geode', unit_price: 100)}
  let!(:item_3) {merchant_1.items.create!(name: 'Brown Pebble', description: 'Classic rock', unit_price: 50)}
  let!(:item_4) {merchant_1.items.create!(name: 'Red Rock', description: 'A big red rock', unit_price: 50)}
  let!(:item_5) {merchant_1.items.create!(name: 'Solid Limestone', description: 'not crumbly', unit_price: 50,)}
  let!(:item_5) {merchant_2.items.create!(name: 'Golden Trumpet', description: 'sings sweetly', unit_price: 1000,)}



  it "sends a list of all items(index)" do

    get '/api/v1/items'

    expect(response).to be_successful

    items = JSON.parse(response.body, symbolize_names: true)

    expect(items[:data].count).to eq(5)

    items[:data].each do |item|
     expect(item).to have_key(:id)
     expect(item[:id]).to be_a(String)

     expect(item).to have_key(:type)
     expect(item[:type]).to eq("item")

     expect(item[:attributes]).to have_key(:name)
     expect(item[:attributes][:name]).to be_a(String)


     expect(item[:attributes]).to have_key(:created_at)
     expect(item[:attributes][:created_at]).to be_a(String)

     expect(item[:attributes]).to have_key(:updated_at)
     expect(item[:attributes][:updated_at]).to be_a(String)

     expect(item[:attributes]).to have_key(:description)
     expect(item[:attributes][:description]).to be_a(String)

     expect(item[:attributes]).to have_key(:unit_price)
     expect(item[:attributes][:unit_price]).to be_a(Float)

     expect(item[:attributes]).to have_key(:merchant_id)
     expect(item[:attributes][:merchant_id]).to be_an(Integer)

   end
  end

  it "sends info for a single item(show)" do
    get "/api/v1/items/#{item_1.id}"

    expect(response).to be_successful

    item = JSON.parse(response.body, symbolize_names: true)

    expect(item[:data]).to have_key(:id)
    expect(item[:data][:id]).to be_a(String)

    expect(item[:data][:attributes]).to have_key(:name)
    expect(item[:data][:attributes][:name]).to be_a(String)
    expect(item[:data][:attributes][:name]).to eq("Obsidian Nobice")


    expect(item[:data][:attributes]).to have_key(:created_at)
    expect(item[:data][:attributes][:created_at]).to be_a(String)

    expect(item[:data][:attributes]).to have_key(:updated_at)
    expect(item[:data][:attributes][:updated_at]).to be_a(String)

    expect(item[:data][:attributes]).to have_key(:description)
    expect(item[:data][:attributes][:description]).to be_a(String)
    expect(item[:data][:attributes][:description]).to eq("A beautiful obsidian")


    expect(item[:data][:attributes]).to have_key(:unit_price)
    expect(item[:data][:attributes][:unit_price]).to be_a(Float)
    expect(item[:data][:attributes][:unit_price]).to eq(50.0)


    expect(item[:data][:attributes]).to have_key(:merchant_id)
    expect(item[:data][:attributes][:merchant_id]).to be_an(Integer)
    expect(item[:data][:attributes][:merchant_id]).to eq(merchant_1.id)

  end
end