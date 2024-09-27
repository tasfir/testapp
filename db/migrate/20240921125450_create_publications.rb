class CreatePublications < ActiveRecord::Migration[7.2]
  def change
    create_table :publications do |t|
      t.string :name
      t.string :address
      t.decimal :opening_balance, precision: 10, scale: 2  # changed to
      t.timestamps
      t.string :status, null: false, default: 'published' # Use a string for the default value
    end
  end
end
