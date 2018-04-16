class CreateTransactions < ActiveRecord::Migration[5.1]
  def change
    create_table :transactions do |t|
      t.string :beneficiary_iban
      t.string :emitter_iban
      t.integer :vat_amount
      t.integer :amount
      t.integer :fee_amount
      t.text :note
      t.string :emitter_bic
      t.string :beneficiary_bic
      t.string :reference
      t.string :status
      t.references :beneficiary_company, index: true, foreign_key: { to_table: :companies }
      t.references :emitter_company, index: true, foreign_key: { to_table: :companies }

      t.timestamps
    end
  end
end
