# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'faker'

# treatments seed

Customer.all.each do |customer|
  treatment = Treatment.create(overview: Faker::Cannabis.health_benefit)

  customer.treatment = treatment
  customer.save
end

# treatment task seed

Treatment.all.each do |treatment|
  for i in (1..rand(1..10))
    TreatmentTask.create(label: Faker::Cannabis.medical_use, treatment: treatment)
  end
end

# patient statuses seed

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

Customer.all.each do |customer|
  customer.avatar = Faker::Avatar.image
  customer.birth_date = Faker::Date.between(18.year.ago, 50.year.ago)
  customer.phone = Faker::PhoneNumber.phone_number
  customer.save
end
