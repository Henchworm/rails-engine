module Response
  def json_response(object, status = :ok)
    # binding.pry

    if object[:message].present?
      render json: object[:message].to_json, status: 404
    elsif object[:errors].present?
      render json: object[:errors].to_json, status: 404
    elsif object.class == Hash
        render json: {error: object[:error]}.to_json, status: 404
    elsif object.errors.present?
      render json: object.errors.messages.to_json, status: 404
    elsif object.class == Item
     render json: ItemSerializer.new(object), status: status
    elsif object.class == Merchant
     render json: MerchantSerializer.new(object), status: status
    end
  end
end