# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

Faker::Config.locale = "en"

# ---------------------------------------------------------------------------
# Groups (product categories)
# ---------------------------------------------------------------------------
puts "Seeding groups..."

GROUP_NAMES = [
  "Electronics", "Groceries", "Stationery", "Home Appliances",
  "Fashion & Apparel", "Toys & Games", "Health & Beauty", "Sports & Outdoors"
].freeze

groups = GROUP_NAMES.map do |name|
  Group.find_or_create_by!(name: name) { |g| g.status = "published" }
end

# ---------------------------------------------------------------------------
# Publications
# ---------------------------------------------------------------------------
puts "Seeding publications..."

PUBLICATION_NAMES = [
  "Meridian Press Publications", "Northgate Media Publications", "Silverline Journal Publications",
  "Everbright Publications", "Riverside Press Publications", "Beacon Hill Publications",
  "Oakwood Media Publications", "Crimson Type Publications"
].freeze

PUBLICATION_NAMES.each do |name|
  Publication.find_or_create_by!(name: name) do |publication|
    publication.address = Faker::Address.full_address
    publication.opening_balance = Faker::Number.decimal(l_digits: 4, r_digits: 2)
    publication.status = "published"
  end
end

# ---------------------------------------------------------------------------
# Parties (dealers / customers), tied to real Bangladesh divisions/districts/thanas
# ---------------------------------------------------------------------------
puts "Seeding parties..."

districts_with_thanas = District.where(id: Thana.select(:district_id).distinct).to_a

if districts_with_thanas.empty?
  puts "  Skipped: no districts with thanas found. Run db:migrate to load Bangladesh geography data first."
else
  20.times do |i|
    district = districts_with_thanas[i % districts_with_thanas.size]
    thana = Thana.where(district_id: district.id).order(:id).first
    name = "#{Faker::Company.name} Traders"
    email = "party#{i + 1}@example.test"

    Party.find_or_create_by!(email: email) do |party|
      party.division_id = district.division_id
      party.district_id = district.id
      party.thana_id = thana.id
      party.name = name
      party.proprietor = Faker::Name.name
      party.address = Faker::Address.street_address
      party.phone = "01#{rand(3..9)}#{rand(10_000_000..99_999_999)}"
      party.website = Faker::Internet.url
      party.opening_balance = Faker::Number.decimal(l_digits: 5, r_digits: 2)
      party.remarks = Faker::Lorem.sentence
      party.status = "published"
    end
  end
end

# ---------------------------------------------------------------------------
# Brands
# ---------------------------------------------------------------------------
puts "Seeding brands..."

BRAND_NAMES = [
  "Northline", "Everstone", "Bluepeak", "Crestmark", "Solara", "Voltway", "Amberly", "Terrahome"
].freeze

brands = BRAND_NAMES.map do |name|
  Brand.find_or_create_by!(name: name) { |b| b.status = "published" }
end

# ---------------------------------------------------------------------------
# Products
# ---------------------------------------------------------------------------
puts "Seeding products..."

25.times do |i|
  sku = format("SKU-%04d", i + 1)
  quantity = rand(0..200)

  Product.find_or_create_by!(sku: sku) do |product|
    product.name = Faker::Commerce.product_name
    product.description = Faker::Commerce.department
    product.content = Faker::Lorem.paragraph(sentence_count: 4)
    product.brand = brands[i % brands.size]
    product.price = Faker::Commerce.price(range: 10.0..500.0)
    product.sale_price = product.price.present? ? (product.price * 0.85).round(2) : nil
    product.cost_per_item = product.price.present? ? (product.price * 0.6).round(2) : nil
    product.quantity = quantity
    product.with_storehouse_management = true
    product.allow_checkout_when_out_of_stock = false
    product.stock_status = quantity.positive? ? "in_stock" : "out_of_stock"
    product.barcode = Faker::Barcode.ean(13)
    product.is_featured = i < 5
    product.order = i
    product.status = "published"
  end
end

puts "Done. Groups: #{Group.count}, Publications: #{Publication.count}, Parties: #{Party.count}, Brands: #{Brand.count}, Products: #{Product.count}"
