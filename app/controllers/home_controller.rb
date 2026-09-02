class HomeController < ApplicationController
  LOW_STOCK_THRESHOLD = 10

  def index
    @products_count = Product.count
    @published_products_count = Product.where(status: Statusable::STATUS_PUBLISHED).count
    @out_of_stock_count = Product.where(with_storehouse_management: true).where(quantity: 0).count
    @low_stock_products = Product.where(with_storehouse_management: true)
                                  .where("quantity > 0 AND quantity <= ?", LOW_STOCK_THRESHOLD)
                                  .order(:quantity)
                                  .limit(5)

    @groups_count = Group.count
    @parties_count = Party.count
    @publications_count = Publication.count

    @recent_products = Product.order(created_at: :desc).limit(5)
  end
end
