class Forest::Product
  include ForestLiana::Collection

  collection :Product

  has_many :buyers, type: ['String'], reference: 'Customer.id'

  segment 'Bestsellers' do
    products = ActiveRecord::Base.connection.execute("""
      SELECT products.id, COUNT(orders.*)
      FROM products
      JOIN orders ON orders.product_id = products.id
      GROUP BY products.id
      ORDER BY count DESC
      LIMIT 10;
    """).to_a

    { id: products.map { |p| p['id'] } }
  end
end
