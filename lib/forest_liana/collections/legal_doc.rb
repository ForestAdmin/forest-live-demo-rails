class Forest::LegalDoc
  include ForestLiana::Collection

  collection :LegalDoc

  field :id, type: 'String'
  field :url, type: 'String', widget: 'link', isReadOnly: true
  field :last_modified, type: 'Date', isReadOnly: true
  field :size, type: 'String', isReadOnly: true
  field :is_verified, type: 'Boolean', isReadOnly: false
end
