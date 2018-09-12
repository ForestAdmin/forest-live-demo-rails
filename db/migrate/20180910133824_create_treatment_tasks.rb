require 'faker'

class CreateTreatmentTasks < ActiveRecord::Migration[5.2]
  def change
    create_table :treatment_tasks do |t|
      t.string :label
      t.boolean :is_done
      t.references :treatment, foreign_key: true

      t.timestamps
    end

    Treatment.all.each do |treatment|
      for i in (1..rand(1..10))
        TreatmentTask.create(label: Faker::Cannabis.medical_use, treatment: treatment)
      end
    end
  end
end
