class CreateFinancialData < ActiveRecord::Migration[5.1]
  def change
    create_table :financial_data do |t|
      t.string :description, default: "Others"
      t.string :details
      t.float :money
      t.string :note, default: "Null"
      t.datetime :commit_time 
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
