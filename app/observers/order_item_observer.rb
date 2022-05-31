class OrderItemObserver < ActiveRecord::Observer

  def after_save(order_item)
    order = order_item.order.reload
    order.recalculate
  end

  def after_destroy(order_item)
    order = order_item.order.reload
    # order.recalculate
  end
end