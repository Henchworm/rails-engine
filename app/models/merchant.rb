class Merchant < ApplicationRecord

  has_many :items
  has_many :invoices, through: :items
  has_many :invoice_items, through: :items
  has_many :transactions, through: :invoices
  has_many :customers, through: :invoices

  def self.return_one
    Merchant.order(:name).first
  end
end
