class Api::V1::MerchantsFindController < ApplicationController

  def show
    # if !params[:name]
    #   render json: { errors: { data: 'Must give search params.' } }, status: 400
    # elsif params[:name] == ''
    #   render json: { errors: { data: 'Search params cannot be empty' } }, status: 400
      merchant_matches = Merchant.where("name ILIKE ?", "%#{params[:name]}%")
      merchant = merchant_matches.return_one
      if merchant == nil
        render json: { errors: { data: "No merchants match your search #{params[:name]}" } }
      else
      json_response(merchant)
      end
    end
  end