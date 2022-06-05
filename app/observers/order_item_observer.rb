class OrderItemObserver < ActiveRecord::Observer

  def before_save(order_item)
    order_item.purchasing_price_cents = order_item.product.price_cents
  end

  def after_save(order_item)
    order = order_item.order.reload
    order.recalculate
  end

  def after_destroy(order_item)
    order = order_item.order.reload
    # order.recalculate
  end
end