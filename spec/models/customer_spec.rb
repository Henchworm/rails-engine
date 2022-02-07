require 'rails_helper'

RSpec.describe Customer, type: :model do
  it "exists" do
    customer_1 = create_list(:customer, 1)
    expect(customer_1.first).to be_a(Customer)
  end
end
