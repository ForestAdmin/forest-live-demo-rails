class Company < ApplicationRecord
  has_many :received_transactions, foreign_key: 'beneficiary_company_id', class_name: 'Transaction'
  has_many :emitted_transactions, foreign_key: 'emitter_company_id', class_name: 'Transaction'

  enum status: { 
    signed_up: 'signed_up', 
    pending: 'pending',
    approved: 'approved',
    rejected: 'rejected', 
    live: 'live' 
  }
end
