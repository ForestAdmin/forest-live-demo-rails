require 'faker'

class AddPhoneToCustomers < ActiveRecord::Migration[5.1]
  def change
    add_column :customers, :phone, :string

    Customer.all.each do |customer|
      customer.phone = Faker::PhoneNumber.phone_number
      customer.save
    end
  end
end
