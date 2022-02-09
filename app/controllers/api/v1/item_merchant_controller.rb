class Api::V1::ItemMerchantController < ApplicationController

  def index
    merchant = Item.find(params[:item_id]).merchant
    json_merchants_response(merchant)
  end
end