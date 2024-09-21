# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.2].define(version: 2024_09_20_125632) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "districts", force: :cascade do |t|
    t.bigint "division_id", null: false
    t.float "lat"
    t.float "long"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "status", default: "published", null: false
    t.index ["division_id"], name: "index_districts_on_division_id"
  end

  create_table "divisions", force: :cascade do |t|
    t.string "code", null: false
    t.float "lat"
    t.float "long"
    t.string "status", default: "published", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["code"], name: "index_divisions_on_code", unique: true
  end

  create_table "parties", force: :cascade do |t|
    t.bigint "division_id", null: false
    t.bigint "district_id", null: false
    t.bigint "thana_id", null: false
    t.string "name"
    t.string "proprietor"
    t.string "address"
    t.string "phone"
    t.string "email"
    t.string "website"
    t.string "opening_balance"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "status", default: "published", null: false
    t.index ["district_id"], name: "index_parties_on_district_id"
    t.index ["division_id"], name: "index_parties_on_division_id"
    t.index ["thana_id"], name: "index_parties_on_thana_id"
  end

  create_table "products", force: :cascade do |t|
    t.string "name", null: false
    t.text "description"
    t.text "content"
    t.string "status", default: "published", null: false
    t.text "images"
    t.string "sku", null: false
    t.integer "order", default: 0, null: false
    t.integer "quantity"
    t.boolean "allow_checkout_when_out_of_stock", default: false, null: false
    t.boolean "with_storehouse_management", default: false, null: false
    t.boolean "is_featured", default: false, null: false
    t.bigint "brand_id"
    t.boolean "is_variation", default: false, null: false
    t.integer "sale_type", default: 0, null: false
    t.float "price"
    t.float "sale_price"
    t.datetime "start_date", precision: nil
    t.datetime "end_date", precision: nil
    t.decimal "length", precision: 8, scale: 2
    t.decimal "wide", precision: 8, scale: 2
    t.decimal "height", precision: 8, scale: 2
    t.decimal "weight", precision: 8, scale: 2
    t.bigint "tax_id"
    t.bigint "views", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "stock_status", default: "in_stock"
    t.bigint "created_by_id", default: 0
    t.string "created_by_type", default: "Botble\\ACL\\Models\\User", null: false
    t.string "image"
    t.string "product_type", default: "physical"
    t.string "barcode", limit: 50
    t.float "cost_per_item"
    t.boolean "generate_license_code", default: false, null: false
    t.bigint "store_id"
    t.bigint "approved_by", default: 0
    t.index ["brand_id"], name: "index_products_on_brand_id"
    t.index ["created_at"], name: "index_products_on_created_at"
    t.index ["end_date"], name: "index_products_on_end_date"
    t.index ["is_variation"], name: "index_products_on_is_variation"
    t.index ["sale_price"], name: "index_products_on_sale_price"
    t.index ["sale_type"], name: "index_products_on_sale_type"
    t.index ["sku"], name: "index_products_on_sku", unique: true
    t.index ["start_date"], name: "index_products_on_start_date"
    t.index ["status"], name: "index_products_on_status"
  end

  create_table "thanas", force: :cascade do |t|
    t.integer "district_id", null: false
    t.float "lat"
    t.float "long"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "status", default: "published", null: false
    t.index ["district_id"], name: "index_thanas_on_district_id"
  end

  create_table "translations", force: :cascade do |t|
    t.string "translatable_type", null: false
    t.bigint "translatable_id", null: false
    t.string "locale"
    t.string "key"
    t.text "value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["translatable_type", "translatable_id"], name: "index_translations_on_translatable"
  end

  add_foreign_key "districts", "divisions"
  add_foreign_key "parties", "districts"
  add_foreign_key "parties", "divisions"
  add_foreign_key "parties", "thanas"
end
