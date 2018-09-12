require 'faker'

class CreateTreatments < ActiveRecord::Migration[5.2]
  def change
    create_table :treatments do |t|
      t.string :overview
      t.references :customer

      t.timestamps
    end

    Customer.all.each do |customer|
      treatment = Treatment.create(overview: Faker::Cannabis.health_benefit)

      customer.treatment = treatment
      customer.save
    end

  end
end
