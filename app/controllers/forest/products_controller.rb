class Forest::ProductsController < ForestLiana::ApplicationController

  def buyers
    limit = params['page']['size'].to_i
    offset = (params['page']['number'].to_i - 1) * limit

    orders = Product.find(params['product_id']).orders
    customers = orders.limit(limit).offset(offset).map(&:customer)
    count = orders.count

    render json: serialize_models(customers, include: ['address'], count: count)
  end
end
