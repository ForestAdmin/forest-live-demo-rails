class CreateAddresses < ActiveRecord::Migration[5.1]
  def change
    create_table :addresses do |t|
      t.string :address_line1
      t.string :address_line2
      t.string :address_city
      t.string :country
      t.references :customer

      t.timestamps
    end
  end
end
