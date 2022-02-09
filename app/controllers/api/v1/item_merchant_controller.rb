class Api::V1::ItemMerchantController < ApplicationController

  def index
    if Item.exists?(params[:item_id])
      merchant = Item.find(params[:item_id]).merchant
      json_response(merchant)
    else
      render json: { errors: { details: "Item with id of #{params[:item_id]} does not exist." }}, status: 404
    end
  end
end