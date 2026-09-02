class InventoryController < ApplicationController
  LOW_STOCK_THRESHOLD = 10

  def index
    tracked = Product.where(with_storehouse_management: true)

    @total_products = Product.count
    @tracked_count = tracked.count
    @total_quantity = tracked.sum(:quantity)
    @total_value = tracked.sum("COALESCE(price, 0) * COALESCE(quantity, 0)")
    @low_stock_count = tracked.where("quantity > 0 AND quantity <= ?", LOW_STOCK_THRESHOLD).count
    @out_of_stock_count = tracked.where(quantity: 0).count

    @filter = params[:filter]
    @products = case @filter
                when "low_stock"
                  tracked.where("quantity > 0 AND quantity <= ?", LOW_STOCK_THRESHOLD)
                when "out_of_stock"
                  tracked.where(quantity: 0)
                when "tracked"
                  tracked
                else
                  Product.all
                end.order(:name)
  end
end
