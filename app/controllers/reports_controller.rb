class ReportsController < ApplicationController
  def index
    tracked = Product.where(with_storehouse_management: true)

    @products_count = Product.count
    @published_products_count = Product.where(status: Statusable::STATUS_PUBLISHED).count
    @total_quantity = tracked.sum(:quantity)
    @total_stock_value = tracked.sum("COALESCE(price, 0) * COALESCE(quantity, 0)")
    @out_of_stock_count = tracked.where(quantity: 0).count

    @products_by_brand = Product.joins(:brand).group("brands.name").count
    @products_without_brand = Product.where(brand_id: nil).count

    @parties_count = Party.count
    @parties_opening_balance = Party.sum(:opening_balance)
    @publications_count = Publication.count
    @publications_opening_balance = Publication.sum(:opening_balance)
    @groups_count = Group.count
  end
end
