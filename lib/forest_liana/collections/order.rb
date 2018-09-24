class Forest::Order
  include ForestLiana::Collection

  collection :Order

  belongs_to :delivery_address, reference: 'Address.id' do
    object.customer.address
  end
end
