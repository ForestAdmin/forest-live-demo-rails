class CreatePatientStatuses < ActiveRecord::Migration[5.2]
  def change
    create_table :patient_statuses do |t|
      t.integer :name

      t.timestamps
    end

    statuses = []

    statuses << PatientStatus.create(name: :signed_up)
    statuses << PatientStatus.create(name: :pending)
    statuses << PatientStatus.create(name: :booked)
    statuses << PatientStatus.create(name: :preparing_diagnostic)
    statuses << PatientStatus.create(name: :diagnostic_delivered)
    statuses << PatientStatus.create(name: :in_treatment)
    statuses << PatientStatus.create(name: :post_treatment)

    add_reference(:customers, :patient_status)

    Customer.all.each do |customer|
      customer.patient_status = statuses.sample
      customer.save
    end
  end
end
