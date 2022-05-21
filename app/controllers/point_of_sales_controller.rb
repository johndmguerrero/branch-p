class PointOfSalesController < ApplicationController

  def index
    @order = current_order
    @product = Product.order('products.category_id asc').group_by(&:category)
  end
end
