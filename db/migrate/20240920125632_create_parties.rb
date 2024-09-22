class CreateParties < ActiveRecord::Migration[7.2]
  def change
    create_table :parties do |t|
      t.references :division, null: false, foreign_key: true
      t.references :district, null: false, foreign_key: true
      t.references :thana, null: false, foreign_key: true

      t.string :name
      t.string :proprietor
      t.string :address
      t.string :phone
      t.string :email
      t.string :website
      t.decimal :opening_balance, precision: 10, scale: 2  # changed to

      t.text :remarks

      t.timestamps
      t.string :status, null: false, default: 'published' # Use a string for the default value
    end
  end
end
