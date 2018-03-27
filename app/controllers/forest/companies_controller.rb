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
end
