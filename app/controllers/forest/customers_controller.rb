class Forest::CustomersController < ForestLiana::ApplicationController

  def generate_invoice
    data = open("#{File.dirname(__FILE__)}/../../../public/invoice-2342.pdf" )
    send_data data.read, filename: 'invoice-2342.pdf', type: 'application/pdf', 
      disposition: 'attachment'
  end

  def charge_credit_card
    amount = params.dig('data', 'attributes', 'values', 'amount').to_i

    render json: { html: <<EOF
<p class="c-clr-1-4 l-mt l-mb">$#{amount / 100.0} USD has been successfuly charged.</p>

<strong class="c-form__label--read c-clr-1-2">Credit card</strong>
<p class="c-clr-1-4 l-mb">**** **** **** 1234</p>

<strong class="c-form__label--read c-clr-1-2">Expire</strong>
<p class="c-clr-1-4 l-mb">09/35</p>

<strong class="c-form__label--read c-clr-1-2">Card type</strong>
<p class="c-clr-1-4 l-mb">VISA</p>

<strong class="c-form__label--read c-clr-1-2">Country</strong>
<p class="c-clr-1-4 l-mb">USA</p>
EOF
    }
  end
end
