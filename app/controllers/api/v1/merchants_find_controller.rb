class Api::V1::MerchantsFindController < ApplicationController

  def show
    merchant_matches = Merchant.where("name ILIKE ?", "%#{params[:name]}%")
    merchant = merchant_matches.return_one
    if merchant != nil
    json_response(merchant)
    else
      render json: { data: {:merchant => [] }}
    end
  end
end