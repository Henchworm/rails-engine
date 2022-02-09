module Response
  
  def json_items_response(object, status = :ok)
    if object[:message].present?
      render json: object[:message], status: status
    elsif object.errors.present?
      render json: object.errors, status: 404
    else
      x = render json: ItemSerializer.new(object), status: status
    end
  end
end