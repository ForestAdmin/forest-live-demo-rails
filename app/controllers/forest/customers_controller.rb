class Forest::CustomersController < ForestLiana::ApplicationController

  def generate_invoice
    data = open("#{File.dirname(__FILE__)}/../../../public/invoice-2342.pdf" )
    send_data data.read, filename: 'invoice-2342.pdf', type: 'application/pdf',
      disposition: 'attachment'
  end

  def charge_credit_card
    customer_id = params.dig('data', 'attributes', 'ids')[0]
    amount = params.dig('data', 'attributes', 'values', 'amount').to_i
    description = params.dig('data', 'attributes', 'values', 'description')

    customer = Customer.find(customer_id)

    response = Stripe::Charge.create(
      amount: amount * 100,
      currency: 'usd',
      customer: customer.stripe_id,
      description: description
    )

    render json: { html: <<EOF
<p class="c-clr-1-4 l-mt l-mb">$#{response.amount / 100.0} USD has been successfuly charged.</p>

<strong class="c-form__label--read c-clr-1-2">Credit card</strong>
<p class="c-clr-1-4 l-mb">**** **** **** #{response.source.last4}</p>

<strong class="c-form__label--read c-clr-1-2">Expire</strong>
<p class="c-clr-1-4 l-mb">#{response.source.exp_month}/#{response.source.exp_year}</p>

<strong class="c-form__label--read c-clr-1-2">Card type</strong>
<p class="c-clr-1-4 l-mb">#{response.source.brand}</p>

<strong class="c-form__label--read c-clr-1-2">Country</strong>
<p class="c-clr-1-4 l-mb">#{response.source.country}</p>
EOF
    }
  end

  def charge_credit_card_values
    context = get_smart_action_context
    render serializer: nil, json: { amount: 666, description: context[:fullname] }, status: :ok
  end
end
