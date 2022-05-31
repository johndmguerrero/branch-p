class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_order, only: [:edit, :add_note, :continue_cart, :process_void]

  def index
    @orders = Order.includes( :order_items, :payment, :user).paginate(page: params[:page])
    @orders = Order.includes( :order_items, :payment, :user).send(params[:type].to_sym).paginate(page: params[:page]) if params[:type].present?
  rescue
    redirect_to orders_path
  end

  def edit

  end
  
  def add_note
    @order.notes.create(user: current_user, message: params[:message])
    @notes = Note.find_by notable_id: @order.id

    respond_to do |format|
      format.turbo_stream { render turbo_stream: turbo_stream.update("notes", partial: 'orders/partials/notes', locals: { notes: @order.notes }) }
    end
  end

  def continue_cart
    @pending_order = Order.pending.first&.draft!
    @order.pending!

    redirect_to point_of_sales_path, flash: { notice: "Continuing order #{@order.order_number} " }
  end

  def process_void
    @order.void_order(by: current_user, message: params[:message])

    redirect_to edit_order_path(id: @order.id), flash: { notice: "Order #{@order.order_number} completelty Voided" }
  end

  private

  def set_order
    @order = Order.includes( :payment, :user, :order_items).find_by id: params[:id]
  end
end
