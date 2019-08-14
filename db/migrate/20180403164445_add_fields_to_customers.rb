require 'faker'

class AddFieldsToCustomers < ActiveRecord::Migration[5.1]
  def change
    add_column :customers, :avatar, :string
    add_column :customers, :birth_date, :date

    t.timestamps
  end
end
