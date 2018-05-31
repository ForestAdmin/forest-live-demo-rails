class Forest::Company
  include ForestLiana::Collection

  collection :Company

  search_fields ['name', 'industry']

  action 'Mark as Live'

  action 'Upload Legal Docs', type: 'single', fields: [{
    field: 'Certificate of Incorporation',
    description: 'The legal document relating to the formation of a company or corporation.',
    type: 'File',
    isRequired: true
  }, {
    field: 'Proof of address',
    description: '(Electricity, Gas, Water, Internet, Landline & Mobile Phone Invoice / Payment Schedule) no older than 3 months of the legal representative of your company',
    type: 'File',
    isRequired: true
  }, {
    field: 'Company bank statement',
    description: 'PDF including company name as well as IBAN',
    type: 'File',
    isRequired: true
  }, {
    field: 'Valid proof of ID',
    description: 'ID card or passport if the document has been issued in the EU, EFTA, or EEA / ID card or passport + resident permit or driving licence if the document has been issued outside the EU, EFTA, or EEA of the legal representative of your company',
    type: 'File',
    isRequired: true
  }]

  action 'Whoami', type: 'global', endpoint: '/forest/whoami', http_method: 'GET'
end
