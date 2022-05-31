module PointOfSalesHelper

  def product_index_collection
    render partial: 'point_of_sales/partials/collection'
  end

  def product_thumbnail(product)
    if product.image.attached?
      image_tag product.thumbnail_image
    else
      "<i class='bi bi-balloon text-primary'></i>".html_safe
    end
  end

  def order_total_cart_item(order)
    order.order_total_quantity
  end

  def order_status_header_info(order)
    if order.paid?
      order.payment.status.capitalize
    else
      order.status.capitalize
    end
  end
end
