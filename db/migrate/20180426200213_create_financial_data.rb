class CreateFinancialData < ActiveRecord::Migration[5.1]
  def change
    create_table :financial_data do |t|
      t.string :details
      t.float :money
      t.integer :type
      t.string :note
      t.datetime :commit_time
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
