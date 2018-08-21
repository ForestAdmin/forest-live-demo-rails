class Customer < ApplicationRecord
  has_one :address
  has_many :orders
  has_many :comments
end
