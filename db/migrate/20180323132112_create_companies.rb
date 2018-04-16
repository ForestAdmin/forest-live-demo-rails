class CreateCompanies < ActiveRecord::Migration[5.1]
  def change
    create_table :companies do |t|
      t.string :name
      t.string :industry
      t.string :headquarter
      t.string :status
      t.text :description
      t.uuid :certificate_of_incorporation_id
      t.uuid :proof_of_address_id
      t.uuid :bank_statement_id
      t.uuid :passport_id

      t.timestamps
    end
  end
end
