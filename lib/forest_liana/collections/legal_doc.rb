class Forest::LegalDoc
  include ForestLiana::Collection

  collection :LegalDoc

  field :id, type: 'String'
  field :url, type: 'String', widget: 'link', is_read_only: true
  field :last_modified, type: 'Date', is_read_only: true
  field :size, type: 'String', is_read_only: true
  field :is_verified, type: 'Boolean', is_read_only: false
end
