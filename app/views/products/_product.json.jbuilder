json.extract! product, :id, :name, :sku, :description, :content, :price, :sale_price, :cost_per_item,
              :quantity, :stock_status, :with_storehouse_management, :allow_checkout_when_out_of_stock,
              :barcode, :image, :is_featured, :order, :status, :created_at, :updated_at
json.url product_url(product, format: :json)
