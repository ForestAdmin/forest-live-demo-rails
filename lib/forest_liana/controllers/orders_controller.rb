if ForestLiana::UserSpace.const_defined?('ProductController')
  ForestLiana::UserSpace::ProductController.class_eval do
    alias_method :index_default, :index

    def index
      if request.params && !request.params['searchExtended'].nil?
        # NOTICE: Seach for collection list, keep the default behaviour.
        index_default
      else
        order_id = request.headers.env['HTTP_REFERER'].match(/record\/[^\/]*\/([^\/]*)\//)
        order_id = order_id[1] if order_id && order_id[1]


        orders = Order.where({ order_id: order_id })
        render json: serialize_models(orders)

      end
    end
  end
end