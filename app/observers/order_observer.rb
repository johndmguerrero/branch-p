class OrderObserver < ActiveRecord::Observer

  def after_initialize(order) 
    order.recalculate
  end

  def before_create(order)
    order_number = generate_number(order)
    order.order_number = order_number
  end

  private

  def generate_number(order)
    order_number = loop do
      order_number = SecureRandom.hex(3).upcase
      break order_number unless order.class.exists? order_number: order_number
    end

    order_number
  end

end