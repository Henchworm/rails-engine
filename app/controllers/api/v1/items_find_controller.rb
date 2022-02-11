class Api::V1::ItemsFindController < ApplicationController
  before_action :find_filter

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
    end
  end

  def find_by_min_price
    item = Item.where("items.unit_price >= ?", params[:min_price].to_f).order(:name)
    if item.first.class != Item
      render json: {data: { item: []}}, status: 400
    else
    render json: ItemSerializer.new(item.first)
    end
  end

  def find_by_max_price
    item = Item.where("items.unit_price <= ?", params[:max_price].to_f).order(:name)
    if item.first.class != Item
      render json: {data: { item: []}}, status: 400
    else
    render json: ItemSerializer.new(item.first)
    end
  end

  private
  def find_filter
    if params[:name] && params[:min_price].present?
      name_price_filter
    elsif params[:name] && params[:max_price].present?
      name_price_filter
    elsif params[:min_price].present? && params[:max_price].present?
      price_comparison_filter
    elsif params[:min_price].present?
      min_price_filter
    elsif params[:max_price].present?
      max_price_filter
    elsif params.has_key?(:name) || params[:name] == nil
      name_filter
    end
  end
end
