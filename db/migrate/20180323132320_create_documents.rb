class CreateDocuments < ActiveRecord::Migration[5.1]
  def change
    create_table :documents do |t|
      t.string :file_id
      t.boolean :is_verified
    end
  end
end
