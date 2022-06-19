class PointOfSalesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_order, only: [:add_to_cart, :remove_item, :draft]
  before_action :set_product, only: [:add_to_cart]
  before_action :set_order_item, only: [:remove_item]

  def index
    @order = current_order
    @product = Product.active.order('products.category_id asc, name asc').group_by(&:category)
    @products = Product.where(type: [nil, 'Product'], quantity: (1..))
  end

  def draft
    @order_to_draft = Order.includes(:order_items).find_by id: params[:id]
    @order_to_draft.draft!

    redirect_to point_of_sales_path, flash: { notice: "Order #{@order_to_draft.order_number} set to draft" }
  end

  def add_to_cart
    @item = OrderService.new(order: @order, product: @product, quantity: 1)
    @item.add_to_cart if !@order.paid?

    respond_to do |format|
      format.turbo_stream do 
        render turbo_stream: [
          turbo_stream.update('cart-offcanvas-body', partial: 'point_of_sales/partials/cart_offcanvas_body', locals: { order: @order }),
          turbo_stream.update('header-order-info', partial: 'point_of_sales/partials/header_order_info', locals: { order: @order }),
          turbo_stream.update('checkout_form', partial: 'point_of_sales/partials/checkout/offcanvas_body', locals: { order: @order })
        ]
      end 
      format.json { render json: @item.response }
    end
  end

  def remove_item
    item = OrderService.new(order: @order, order_item: @item)
    item.remove_item if !@order.paid?

    respond_to do |format|
      format.turbo_stream do
         render turbo_stream: [
           turbo_stream.update('header-order-info', partial: 'point_of_sales/partials/header_order_info', locals: { order: @order }),
           turbo_stream.update('checkout_form', partial: 'point_of_sales/partials/checkout/offcanvas_body', locals: { order: @order }),
           turbo_stream.remove(item.order_item)
         ]
      end if item.processed?
    end
  end

  def confirm_and_complete_order
    @order = Order.includes(:order_items, :payment).find_by id: params[:id]
    @payment = OrderService.new(order: @order, params: params)
    @payment.confirm_payment if @order.pending? && !@order.paid?
    @order.reload
    # @order.payment.confirm!

    respond_to do |format|
      format.turbo_stream do 
        render turbo_stream: [
          turbo_stream.update('checkout_form', partial: 'point_of_sales/partials/checkout/offcanvas_body', locals: { order: @order }),
          turbo_stream.update('cart-offcanvas-body', partial: 'point_of_sales/partials/cart_offcanvas_body', locals: { order: @order })
        ]
      end 
    end
  end

  def complete
    @order = Order.find_by id: params[:id]
    @order.complete!(wallet: current_wallet)
    # @new_order = current_order
    redirect_to point_of_sales_path, flash: { notice: "Order ##{@order.order_number} completed!" }
  end

  def add_package_item
    @order = Order.includes(:order_items).find_by id: params[:id]
    order_item = OrderService.new(order: @order, params: order_item_package_params)
    order_package = order_item.add_package_to_cart
    
    respond_to do |format|
      format.turbo_stream do 
        render turbo_stream: [
          turbo_stream.update('cart-offcanvas-body', partial: 'point_of_sales/partials/cart_offcanvas_body', locals: { order: @order }),
          turbo_stream.update('header-order-info', partial: 'point_of_sales/partials/header_order_info', locals: { order: @order }),
          turbo_stream.update('checkout_form', partial: 'point_of_sales/partials/checkout/offcanvas_body', locals: { order: @order })
        ]
      end 
      format.json { render json: @item.response }
    end
  end

  def search_product
    @products = Product.search_by_keyword(params[:q]).where(type: [nil, 'Product'])
    render layout: false
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

  def order_item_package_params
    params.require(:order_items_package).permit(
      :product_id,
      :order_id,
      :type,
      product_items_attributes: [
        :quantity,
        :product_id
      ]
    )
  end
end
