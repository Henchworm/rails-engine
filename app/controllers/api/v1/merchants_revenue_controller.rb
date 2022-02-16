class Api::V1::MerchantsRevenueController < ApplicationController

  def show
    merchant = Merchant.find(params[:id])
    Merchant.total_revenue(merchant.id)
    json_response(Merchant.find(params[:id]))
  end

end