class Forest::Product
  include ForestLiana::Collection

  collection :Product

  has_many :buyers, type: ['String'], reference: 'Customer.id'

  action 'Import data', endpoint: '/forest/products/actions/import-data', type: 'global', fields: [{
    field: 'CSV file',
    description: 'A semicolon separated values file stores tabular data (numbers and text) in plain text',
    type: 'File',
    isRequired: true
  }, {
    field: 'Type',
    description: 'Specify the product type to import',
    type: 'Enum',
    enums: ['phone', 'dress', 'toy'],
    isRequired: true
  }]

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
