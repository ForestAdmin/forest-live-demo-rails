class Treatment < ApplicationRecord
  belongs_to :customer
  has_many :treatment_tasks
end
