class Forest::CustomerStat
  include ForestLiana::Collection

  collection :CustomerStat, is_searchable: true

  field :id, type: 'Number', is_read_only: true
  field :email, type: 'String', is_read_only: true
  field :orders_count, type: 'Number', is_read_only: true
  field :total_amount, type: 'Number', is_read_only: true

end
