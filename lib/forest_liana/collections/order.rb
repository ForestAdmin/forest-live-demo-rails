class Forest::Order
  include ForestLiana::Collection

  collection :Order

  belongs_to :delivery_address, reference: 'Address.id' do
    object.customer.address
  end

  action 'approve order', endpoint: '/forest/orders/actions/approve-order', type: 'global', fields: [{
    field: 'Select order',
    type: 'Number',
    reference: 'Order.id',
    widget: 'belongsto select'
  }]
end
