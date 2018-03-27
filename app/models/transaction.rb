class Transaction < ApplicationRecord
  belongs_to :beneficiary, foreign_key: 'beneficiary_company_id', class_name: 'Company'
  belongs_to :emitter, foreign_key: 'emitter_company_id', class_name: 'Company'

  enum status: { 
    to_validate: 'to_validate', 
    validated: 'validated',
    rejected: 'rejected', 
  }
end
