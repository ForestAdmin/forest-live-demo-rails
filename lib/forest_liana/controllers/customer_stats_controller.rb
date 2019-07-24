class Forest::CustomerStatsController < ForestLiana::ApplicationController
  require 'jsonapi-serializers'

  before_action :set_params, only: [:index]

  class BaseSerializer
    include JSONAPI::Serializer

    def type
      'customerStat'
    end

    def format_name(attribute_name)
      attribute_name.to_s.underscore
    end

    def unformat_name(attribute_name)
      attribute_name.to_s.dasherize
    end
  end

  class CustomerStatSerializer < BaseSerializer
    attribute :email
    attribute :total_amount
    attribute :orders_count
  end

  def index
    customers_count = Customer.count_by_sql("
      SELECT COUNT(*)
      FROM customers
      WHERE
        EXISTS (
          SELECT *
          FROM orders
          WHERE orders.customer_id = customers.id
        )
        AND email LIKE '%#{@search}%'
    ")
    customer_stats = Customer.find_by_sql("
      SELECT customers.id,
        customers.email,
        count(orders.*) AS orders_count,
        sum(products.price) AS total_amount,
        customers.created_at,
        customers.updated_at
      FROM customers
      JOIN orders ON customers.id = orders.customer_id
      JOIN products ON orders.product_id = products.id
      WHERE email LIKE '%#{@search}%'
      GROUP BY customers.id
      ORDER BY customers.id
      LIMIT #{@limit}
      OFFSET #{@offset}
    ")
    customer_stats_json = CustomerStatSerializer.serialize(customer_stats, is_collection: true, meta: {count: customers_count})
    render json: customer_stats_json
  end

  private

  def set_params
    @limit = params[:page][:size].to_i
    @offset = (params[:page][:number].to_i - 1) * @limit
    @search = sanitize_sql_like(params[:search]? params[:search] : "")
  end

  def sanitize_sql_like(string, escape_character = "\\")
    pattern = Regexp.union(escape_character, "%", "_")
    string.gsub(pattern) { |x| [escape_character, x].join }
  end
end
