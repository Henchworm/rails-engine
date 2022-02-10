class Api::V1::MerchantsFindController < ApplicationController

  def index
    if !params[:name]
      render json: { errors: { details: 'No params.' } }, status: 400
    elsif params[:name] == ''
      render json: { errors: { details: 'Empty params.' } }, status: 400
    else
      merchant_matches = Merchant.where("name ILIKE ?", "%#{params[:name]}%")
      render json: MerchantSerializer.new(merchant_matches)
    end
  end

  def show
    if !params[:name]
      render json: { errors: { details: 'No params.' } }, status: 400
    elsif params[:name] == ''
      render json: { errors: { details: 'Empty params.' } }, status: 400
    else
      merchant_matches = Merchant.where("name ILIKE ?", "%#{params[:name]}%")
      merchant = merchant_matches.return_one
    if merchant != nil
      json_response(merchant)
    else
      render json: { data: {:merchant => [] }}
    end
    end
  end

end