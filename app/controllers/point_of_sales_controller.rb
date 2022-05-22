class PointOfSalesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_order, only: [:add_to_cart, :remove_item]
  before_action :set_product, only: [:add_to_cart]
  before_action :set_order_item, only: [:remove_item]

  def index
    @order = current_order
    @product = Product.order('products.category_id asc').group_by(&:category)
  end

  def add_to_cart
    @item = OrderService.new(order: @order, product: @product, quantity: 1)
    @item.add_to_cart

    respond_to do |format|
      format.turbo_stream do 
        render turbo_stream: [
          turbo_stream.update('cart-offcanvas-body', partial: 'point_of_sales/partials/cart_offcanvas_body', locals: { order: @order }),
          turbo_stream.update('header-order-info', partial: 'point_of_sales/partials/header_order_info', locals: { order: @order })
        ]
      end 
      format.json { render json: @item.response }
    end
  end

  def remove_item
    item = OrderService.new(order: @order, order_item: @item)
    item.remove_item

    respond_to do |format|
      format.turbo_stream do
         render turbo_stream: [
           turbo_stream.update('header-order-info', partial: 'point_of_sales/partials/header_order_info', locals: { order: @order }),
           turbo_stream.remove(item.order_item)
         ]
      end if item.processed?
    end
  end

  private

  def set_order
    @order = Order.includes(:order_items).find_by id: params[:order_id]
  end

  def set_product
    @product = Product.includes(:category).find_by id: params[:id]
  end

  def set_order_item
    @item = OrderItem.find_by id: params[:id]
  end
end
