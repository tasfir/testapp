class CreateProducts < ActiveRecord::Migration[7.2]
  def change
    create_table :products do |t|
      t.string :name, null: false
      t.text :description
      t.text :content # No limit specified, will use the default
      t.string :status, index: true, default: 'published', null: false
      t.text :images
      t.string :sku, null: false
      t.integer :order, default: 0, null: false
      t.integer :quantity
      t.boolean :allow_checkout_when_out_of_stock, default: false, null: false
      t.boolean :with_storehouse_management, default: false, null: false
      t.boolean :is_featured, default: false, null: false
      t.bigint :brand_id, index: true
      t.boolean :is_variation, index: true, default: false, null: false
      t.integer :sale_type, index: true, default: 0, null: false
      t.float :price
      t.float :sale_price, index: true
      t.timestamp :start_date, index: true
      t.timestamp :end_date, index: true
      t.decimal :length, precision: 8, scale: 2
      t.decimal :wide, precision: 8, scale: 2
      t.decimal :height, precision: 8, scale: 2
      t.decimal :weight, precision: 8, scale: 2
      t.bigint :tax_id
      t.bigint :views, default: 0, null: false
      t.timestamps
      t.string :stock_status, default: 'in_stock'
      t.bigint :created_by_id, default: 0
      t.string :created_by_type, default: 'Botble\\ACL\\Models\\User', null: false
      t.string :image
      t.string :product_type, default: 'physical'
      t.string :barcode, limit: 50
      t.float :cost_per_item
      t.boolean :generate_license_code, default: false, null: false
      t.bigint :store_id
      t.bigint :approved_by, default: 0

      t.index :created_at
      t.index :sku, unique: true  # Unique index for sku
    end
  end
end
