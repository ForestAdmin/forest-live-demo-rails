class Forest::CompaniesController < ForestLiana::ApplicationController
  def mark_as_live
    render status: 400, json: { error: 'You can only read data on this public demo application.' }
  end

  def upload_legal_docs
    render status: 400, json: { error: 'You can only read data on this public demo application.' }
  end

  def add_new_transaction
    attrs = params.dig('data','attributes', 'values')
    beneficiary_company_id = attrs['Beneficiary company']
    emitter_company_id = ForestLiana::ResourcesGetter.get_ids_from_request(params, forest_user)
    amount = attrs['Amount']
    Transaction.create!(
      emitter_company_id: emitter_company_id,
      beneficiary_company_id: beneficiary_company_id,
      beneficiary_iban: Faker::Code.imei,
      emitter_iban: Faker::Code.imei,
      vat_amount: Faker::Number.number(4),
      fee_amount: Faker::Number.number(4),
      status: ['to_validate', 'validated', 'rejected'].sample,
      note: Faker::Lorem.paragraph,
      amount: amount,
      emitter_bic: Faker::Code.nric,
      beneficiary_bic: Faker::Code.nric
    )

    # the code below automatically refresh the related data
    # 'emitted_transactions' on the Companies' Summary View
    # after submitting the Smart action form.
    render json: {
      success: 'New transaction emitted',
      refresh: { relationships: ['emitted_transactions'] },
    }
  end
end
