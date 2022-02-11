module ParamsFilter

  def name_filter
    if params[:name] == nil
     render json: JSON.generate({ errors: { details: 'No params.' } }), status: 400
   elsif params[:name] == ""
      render json: JSON.generate({ errors: { details: 'Empty params.' } }), status: 400
    end
  end

  def min_price_filter
    if params[:min_price] == nil
     render json: JSON.generate({ errors: { details: 'No params.' }}), status: 400
    elsif params[:min_price] == ""
      render json: JSON.generate({ errors: { details: 'Empty params.' }}), status: 400
    elsif params[:min_price].to_f < 0.0
      render json: JSON.generate({ error: { error: 'Price cannot be less than 0.' }}), status: 400
    else
      find_by_min_price
    end
  end

  def max_price_filter
    if params[:max_price] == nil
     render json: JSON.generate({ errors: { details: 'No params.' } }), status: 400
    elsif params[:max_price] == ""
      render json: JSON.generate({ errors: { details: 'Empty params.' } }), status: 400
    elsif params[:max_price].to_f < 0.0
      render json: JSON.generate({ error: { error: 'Price cannot be less than 0.' }}), status: 400
    else
      find_by_max_price
    end
  end

  def price_comparison_filter
    if params[:max_price].to_f < params[:min_price].to_f
      render json: JSON.generate({ errors: { error: 'Min price cannot be less than max price.' }}), status: 400
    end
  end

  def name_price_filter
    render json: JSON.generate({ errors: { details: 'Too many params.' } }), status: 400
  end
end
