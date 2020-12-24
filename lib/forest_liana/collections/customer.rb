class Forest::Customer
  include ForestLiana::Collection

  collection :Customer

  action 'Charge credit card',
         type: 'single',
         fields: [{
                      field: 'amount',
                      is_required: true,
                      description: 'The amount (USD) to charge the credit card. Example: 42.50',
                      type: 'Number'
                  }, {
                      field: 'description',
                      is_required: true,
                      description: 'Explain the reason why you want to charge manually the customer here',
                      type: 'String',
                      widget: 'rich text editor'
                  },{
                      field: 'stripe_id',
                      type: 'String'
                  },{
                     field: 'baz',
                     type: 'Enum',
                     enums: ['a', 'b', 'c']
                   },],
         hooks: {
             :load => -> (context){
               context[:fields]['amount'][:value] = 1000
               context[:fields]['description'][:value] = 'foo'
               return context[:fields]
             },
             :change => {
                 'amount' => -> (context){
                    context[:fields]['amount'][:value] = 2000

                    context[:fields]['baz'][:enums] = ['c', 'd', 'e']

                    return context[:fields]
                 },
                 'description' => -> (context){
                   context[:fields]['description'][:value] = 'bar'
                   return context[:fields]
                 }
             }
         }

  action 'Generate invoice', download: true

  set_fullname = lambda do |user_params, fullname|
    fullname = fullname.split
    user_params[:firstname] = fullname.first
    user_params[:lastname] = fullname.last

    # Returns a hash of the updated values you want to persist.
    user_params
  end

  search_fullname = lambda do |query, search|
    firstname, lastname = search.split

    # Injects your new filter into the WHERE clause.
    query.where_clause.send(:predicates)[0] << " OR (firstname = '#{firstname}' AND lastname = '#{lastname}')"

    query
  end

  field :fullname, type: 'String', set: set_fullname, search: search_fullname do
    "#{object.firstname} #{object.lastname}"
  end

  field :full_address, type: 'String' do
    address = Address.find_by(customer_id: object.id)
    "#{address[:address_line_1]} #{address[:address_line_2]} #{address[:address_city]} #{address[:country]}"
  end

  field :age, type: 'Number' do
    ((Time.zone.now - object.birth_date.to_time) / 1.year.seconds).floor if object.birth_date
  end
end
