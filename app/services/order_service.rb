class OrderService
  attr_accessor :params, :order, :product, :order_item, :processed, :message, :quantity, :item, :response

  def initialize(options = {})
    self.order      = options[:order]
    self.product    = options[:product]
    self.order_item = options[:order_item]
    self.params     = options[:params]
    self.quantity   = options[:quantity]
    self.item       = options[:item]
    self.processed  = false
    self.message    = ""
    self.response   = nil
  end

  def add_to_cart
    item = order.order_items.find_or_initialize_by(product_id: product.id)
    if item.persisted? # existing record
      item.quantity = item.quantity + quantity
      self.message = "Success "
    elsif item.new_record? # new record
      item.quantity = 1
      self.message = "Success add to cart #{item.product&.name}"
    end


    self.processed = true if item.save
    if processed?
      self.item     = item
      self.order    = item.order
      self.response = { 
        object: item.as_json, 
        total_quantity: order.order_total_quantity, 
        subtotal: ActionController::Base.helpers.humanized_money(order.subtotal)
      }
    end
  end

  def remove_item
    item = order.order_items.find_by id: order_item.id
    self.processed = true if item.destroy

    item
  end

  def confirm_payment
    payment = order.payment
    payment = order.create_payment if payment.nil?

    payment.amount_paid = params[:received]
    payment.remarks = params[:remarks]
    payment.change_cents = payment.amount_paid_cents - order.total_cents
    payment.paid!
  end

  def add_package_to_cart
    return false if params[:product_items_attributes].blank?
    order_package = order.order_items.create(type: params[:type], product_id: params[:product_id])
    params[:product_items_attributes].each do |item, value|
      product_items = order_package.product_items.create(value)
    end

    order_package
  end

  def processed?
    processed == true
  end

end