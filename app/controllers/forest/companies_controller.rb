class Forest::CompaniesController < ForestLiana::ApplicationController
  def mark_as_live
    company_id = params.dig('data', 'attributes', 'ids').first
    Company.update(company_id, status: 'live')

    head :no_content
  end

  def upload_legal_doc(company_id, doc, field)
    id = SecureRandom.uuid

    Forest::S3Helper.new.upload(doc, "livedemo/legal/#{id}")

    company = Company.find(company_id)
    company[field] = id
    company.save

    Document.create({
      file_id: company[field],
      is_verified: true
    })
  end

  def upload_legal_docs
    # Get the current company id
    company_id = params.dig('data', 'attributes', 'ids')[0]

    # Get the values of the input fields entered by the admin user.
    attrs = params.dig('data', 'attributes', 'values')
    certificate_of_incorporation = attrs['Certificate of Incorporation'];
    proof_of_address = attrs['Proof of address'];
    company_bank_statement = attrs['Company bank statement'];
    passport_id = attrs['Valid proof of ID'];

    # The business logic of the Smart Action. We use the function
    # upload_legal_doc to upload them to our S3 repository. You can see the
    # full implementation on our Forest Live Demo repository on Github.
    upload_legal_doc(company_id, certificate_of_incorporation, 'certificate_of_incorporation_id')
    upload_legal_doc(company_id, proof_of_address, 'proof_of_address_id')
    upload_legal_doc(company_id, company_bank_statement, 'bank_statement_id')
    upload_legal_doc(company_id, passport_id, 'passport_id')

    # Once the upload is finished, send a success message to the admin user in the UI.
    render json: { success: 'Legal documents are successfully uploaded.' }
  end

  def add_new_transaction
    attrs = params.dig('data','attributes', 'values')
    beneficiary_company_id = attrs['Beneficiary company']
    emitter_company_id = params.dig('data','attributes')['ids'][0]
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
