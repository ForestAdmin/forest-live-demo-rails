class Forest::Transaction
  include ForestLiana::Collection

  collection :Transaction

  action 'Approve Transaction'
  action 'Reject Transaction', fields: [{
    field: 'Reason',
    description: '⚠️ The reason will be sent to the customer ⚠️',
    type: 'String',
    widget: 'text area',
    isRequired: true
  }]

  field :health_status, type: 'Enum', enums: ['suspicious', 'healthy'] do
    case object.status
    when 'to_validate'
      ['suspicious', 'healthy'].sample
    when 'rejected'
      'suspicious'
    when 'validated'
      'healthy'
    end
  end

  field :beneficiary_headquarter, type: 'String' do
    object.beneficiary[:headquarter]
  end

  field :emitter_headquarter, type: 'String' do
    object.emitter[:headquarter]
  end
end
