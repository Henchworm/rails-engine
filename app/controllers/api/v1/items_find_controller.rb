class Api::V1::ItemsFindController < ApplicationController

  def index
    if !params[:name]
      render json: { errors: { details: 'No params.' } }, status: 400
    elsif params[:name] == ''
      render json: { errors: { details: 'Empty params.' } }, status: 400
    else
    items = Item.where("name ILIKE ?", "%#{params[:name]}%")
    render json: ItemSerializer.new(items)
  end

  def show

      item = Item.where("name ILIKE ?", "%#{params[:name]}%")
      if item.first != nil
        json_response(item.first)
      else
        render json: {data: {object: ItemSerializer.new(item) }}
      end
    end
  end
end