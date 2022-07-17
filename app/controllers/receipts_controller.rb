class ReceiptsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_order, only: [:index]

  def index
    redirect_to orders_path if @order.nil?
  end

  private

  def set_order
    @order = Order.includes( :payment, :user, :order_items).find_by order_number: params[:order_number]
  end
end
