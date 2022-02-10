class Api::V1::ItemsFindController < ApplicationController

  def index
    items = Item.where("name ILIKE ?", "%#{params[:name]}%")
    render json: ItemSerializer.new(items)
  end

  def show
    item = Item.where("name ILIKE ?", "%#{params[:name]}%")
    if item.first != nil
      json_response(item.first)
    else
    render json: {data: {object: ItemSerializer.new(item) }}
    #i know this is janky
    end
  end
end