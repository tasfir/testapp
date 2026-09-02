class Product < Statusable
  STOCK_STATUSES = %w[in_stock out_of_stock].freeze

  belongs_to :brand, optional: true

  validates :name, presence: true
  validates :sku, presence: true, uniqueness: true
  validates :stock_status, inclusion: { in: STOCK_STATUSES }, allow_nil: true
end
