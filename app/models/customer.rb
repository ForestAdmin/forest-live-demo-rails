class Customer < ApplicationRecord
  has_one :address
  has_many :orders

  belongs_to :patient_status
  has_one :treatment
end
