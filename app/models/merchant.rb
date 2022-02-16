class Merchant < ApplicationRecord

  has_many :items
  has_many :invoices, through: :items
  has_many :invoice_items, through: :items
  has_many :transactions, through: :invoices
  has_many :customers, through: :invoices

  def self.return_one
    Merchant.order(:name).first
  end

  def self.total_revenue(id)
    joins(invoice_items: {invoice: :transactions})
      .where( merchants: { id: id }, transactions: {result: "success"}, invoices: {status: "shipped"})
      .group(:id)
      .select("SUM(invoice_items.quantity * invoice_items.unit_price) AS revenue ")
      .first
      .revenue
  end
end
