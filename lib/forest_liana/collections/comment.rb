class Forest::Comment
  include ForestLiana::Collection

  collection :Comment
  
  action 'add comment', type: 'global', fields: [{
    field: 'Content',
    type: 'String',
    isRequired: true
  }]
end