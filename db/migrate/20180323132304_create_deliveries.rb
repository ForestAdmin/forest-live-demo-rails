class CreateDeliveries < ActiveRecord::Migration[5.1]
  def change
    create_table :deliveries do |t|
      t.string :phone
      t.decimal :lng
      t.decimal :lat
      t.boolean :is_delivered

      t.timestamps
    end
  end
end
