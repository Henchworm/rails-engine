class Api::V1::ItemsFindController < ApplicationController

  def index
    items = Item.where("name ILIKE ?", "%#{params[:name]}%")
    render json: ItemSerializer.new(items)
  end
end