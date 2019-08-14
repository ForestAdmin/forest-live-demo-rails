require 'faker'

class AddPhoneToCustomers < ActiveRecord::Migration[5.1]
  def change
    add_column :customers, :phone, :string

    t.timestamps
  end
end
