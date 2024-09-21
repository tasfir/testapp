class CreateTranslations < ActiveRecord::Migration[7.2]
  def change
    create_table :translations do |t|
      t.references :translatable, polymorphic: true, null: false
      t.string :locale
      t.string :key
      t.text :value

      t.timestamps
    end
  end
end
