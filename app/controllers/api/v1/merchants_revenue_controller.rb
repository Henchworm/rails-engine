class Api::V1::MerchantsRevenueController < ApplicationController

  def show
    merchant = Merchant.find(params[:id])
    render json: {data: {type: "merchant_revenue", id: merchant.id.to_s, attributes: {revenue: Merchant.total_revenue(merchant.id)}}}
  end
end