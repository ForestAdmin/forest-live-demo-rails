class Appointment < ApplicationRecord
  enum status: { 
    confirmed: 'confirmed', 
    unconfirmed: 'unconfirmed'
  }
end
