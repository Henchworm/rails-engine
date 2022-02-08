require 'rails_helper'
RSpec.describe "Merchants API" do

  it "sends a list of all merchants(index)" do
    create_list(:merchant, 5)

    get '/api/v1/merchants'

    expect(response).to be_successful

    merchants = JSON.parse(response.body, symbolize_names: true)


    expect(merchants[:data].count).to eq(5)

    merchants[:data].each do |merchant|
     expect(merchant).to have_key(:id)
     expect(merchant[:id]).to be_a(String)

     expect(merchant).to have_key(:type)
     expect(merchant[:type]).to eq("merchant")

     expect(merchant[:attributes]).to have_key(:name)
     expect(merchant[:attributes][:name]).to be_a(String)


     expect(merchant[:attributes]).to have_key(:created_at)
     expect(merchant[:attributes][:created_at]).to be_a(String)

     expect(merchant[:attributes]).to have_key(:updated_at)
     expect(merchant[:attributes][:updated_at]).to be_a(String)
   end
  end

  it "sad path no merchants(index) blank parse" do
      get '/api/v1/merchants'
      expect(response).to be_successful
      merchants = JSON.parse(response.body, symbolize_names: true)
      expect(merchants).to eq({data:[]})
  end

  it "sends info for a single merchant(show)" do
    merchant_1 = Merchant.create!(name: "Billy's Pet Rocks")
    item_1 = merchant_1.items.create!(name: 'Obsidian Nobice', description: 'A beautiful obsidian', unit_price: 500)
    get "/api/v1/merchants/#{merchant_1.id}"

    expect(response).to be_successful

    merchant = JSON.parse(response.body, symbolize_names: true)

    expect(merchant[:data]).to have_key(:id)
    expect(merchant[:data][:id]).to be_a(String)

    expect(merchant[:data][:attributes]).to have_key(:name)
    expect(merchant[:data][:attributes][:name]).to be_a(String)
    expect(merchant[:data][:attributes][:name]).to eq("Billy's Pet Rocks")


    expect(merchant[:data][:attributes]).to have_key(:created_at)
    expect(merchant[:data][:attributes][:created_at]).to be_a(String)

    expect(merchant[:data][:attributes]).to have_key(:updated_at)
    expect(merchant[:data][:attributes][:updated_at]).to be_a(String)
  end

  xit "sad path no merchant(show) blank parse" do
      get '/api/v1/merchants/1'
      expect(response).to be_successful
      merchant = JSON.parse(response.body, symbolize_names: true)
      binding.pry
      expect(merchants).to eq({data:[]})
  end
end