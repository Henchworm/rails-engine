class Api::V1::RevenueController < ApplicationController
  def show
    unshipped = Invoice.where(status: "pending")
    unshipped_revenue = Invoice.unshipped_revenue
  end
end
