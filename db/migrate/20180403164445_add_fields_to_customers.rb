require 'faker'

class AddFieldsToCustomers < ActiveRecord::Migration[5.1]
  def change
    add_column :customers, :avatar, :string
    add_column :customers, :birth_date, :date

    Customer.all.each do |customer|
      customer.avatar = Faker::Avatar.image
      customer.birth_date = Faker::Date.between(18.year.ago, 50.year.ago)

      customer.save
    end
  end
end
