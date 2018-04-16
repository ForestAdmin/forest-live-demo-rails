class CreateAppointments < ActiveRecord::Migration[5.1]
  def change
    create_table :appointments do |t|
      t.string :name
      t.text :reason
      t.datetime :start_date
      t.datetime :end_date
      t.string :status

      t.timestamps
    end
  end
end
