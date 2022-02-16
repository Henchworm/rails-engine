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
    get "/api/v1/merchants/#{merchant_1.id}"

    expect(response).to be_successful

    merchant = JSON.parse(response.body, symbolize_names: true)

    expect(merchant[:data]).to have_key(:id)
    expect(merchant[:data][:id]).to be_a(String)

    expect(merchant[:data][:attributes]).to have_key(:name)
    expect(merchant[:data][:attributes][:name]).to be_a(String)
    expect(merchant[:data][:attributes][:name]).to eq("Billy's Pet Rocks")
  end

  it "sad path no merchant(show) blank parse" do
      get '/api/v1/merchants/1'

      expect(response).to_not be_successful

      fail_response = JSON.parse(response.body, symbolize_names: true)

      expect(fail_response[:error][:message]).to eq("Couldn't find Merchant with 'id'=1")
  end

  it "merchants total revenue" do
    merchant_1 = Merchant.create!(name: "Billy's Pet Rocks")
    item_1 = merchant_1.items.create!(name: 'Obsidian Nobice', description: 'A beautiful obsidian', unit_price: 0)
    item_2 = merchant_1.items.create!(name: 'Green Obsidian Cup', description: 'An obsidian cup', unit_price: 0)
    item_3 = merchant_1.items.create!(name: 'Dirt', description: 'dirt', unit_price: 0)
    customer_1 = Customer.create!(first_name: "Billy", last_name: "Carruthurs")
    invoice_1 = customer_1.invoices.create!(customer_id: 1, status: "shipped")
    invoice_item_1 = InvoiceItem.create!(item_id: item_1.id, invoice_id: invoice_1.id, quantity: 1, unit_price: 1)
    invoice_item_2 = InvoiceItem.create!(item_id: item_2.id, invoice_id: invoice_1.id, quantity: 1, unit_price: 1)
    invoice_item_3 = InvoiceItem.create!(item_id: item_3.id, invoice_id: invoice_1.id, quantity: 1, unit_price: 1)
    transaction_1 = Transaction.create!(invoice_id: invoice_1.id, credit_card_number: "4", credit_card_expiration_date: "3", result: "success")
    get "/api/v1/revenue/merchants/#{merchant_1.id}/"
    expect(response).to be_successful
    parsed = JSON.parse(response.body, symbolize_names: true)
    expect(parsed[:data][:type]).to eq("merchant_revenue")
    expect(parsed[:data][:attributes][:revenue]).to eq(3.0)
  end

  it "total unshipped revenue" do
    #I KNOW THIS SHOULD BE IN A DIFFERENT SPEC FILE :-) 
    merchant_1 = Merchant.create!(name: "Billy's Pet Rocks")
    item_1 = merchant_1.items.create!(name: 'Obsidian Nobice', description: 'A beautiful obsidian', unit_price: 0)
    item_2 = merchant_1.items.create!(name: 'Green Obsidian Cup', description: 'An obsidian cup', unit_price: 0)
    item_3 = merchant_1.items.create!(name: 'Dirt', description: 'dirt', unit_price: 0)
    customer_1 = Customer.create!(first_name: "Billy", last_name: "Carruthurs")
    invoice_1 = customer_1.invoices.create!(customer_id: 1, status: "pending")
    invoice_item_1 = InvoiceItem.create!(item_id: item_1.id, invoice_id: invoice_1.id, quantity: 1, unit_price: 1)
    invoice_item_2 = InvoiceItem.create!(item_id: item_2.id, invoice_id: invoice_1.id, quantity: 1, unit_price: 1)
    invoice_item_3 = InvoiceItem.create!(item_id: item_3.id, invoice_id: invoice_1.id, quantity: 1, unit_price: 1)
    transaction_1 = Transaction.create!(invoice_id: invoice_1.id, credit_card_number: "4", credit_card_expiration_date: "3", result: "success")
    get "/api/v1/revenue/unshipped"
  end
end


