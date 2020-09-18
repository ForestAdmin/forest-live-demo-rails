class Forest::Order
  include ForestLiana::Collection

  collection :Order

  belongs_to :delivery_address, reference: 'Address.id' do
    object.customer ? object.customer.address : nil
  end
end
