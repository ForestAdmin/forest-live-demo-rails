class PatientStatus < ApplicationRecord
  enum name: [:signed_up, :pending, :booked, :preparing_diagnostic,
              :diagnostic_delivered, :in_treatment, :post_treatment]
  has_many :customers
end
