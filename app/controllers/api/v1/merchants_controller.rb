class Api::V1::MerchantsController < ApplicationController

  def index
    render json: MerchantSerializer.new(Merchant.all)
  end

  def show
    json_merchants_response(Merchant.find(params[:id]))
  end
end