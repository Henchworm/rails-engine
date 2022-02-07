require 'rails_helper'

RSpec.describe Merchant, type: :model do
  it "exists" do
    merchant_1 = Merchant.create!(name: "Billys Pet Rocks")
    expect(merchant_1).to be_a(Merchant)
  end

  describe 'relationships' do
    it { should have_many(:items) }
    it { should have_many(:invoices).through(:items)}
    it { should have_many(:invoice_items).through(:items)}
    it { should have_many(:transactions).through(:invoices)}
    it { should have_many(:customers).through(:invoices)}
  end
end
