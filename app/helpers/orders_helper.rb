module OrdersHelper

  def orders_index_view
    if @orders.present?
      render partial: 'orders/partials/table'
    else
      render partial: 'orders/placeholders/table'
    end
  end

  def order_index_status(status)
    helper = {
      complete: 'success',
      pending: 'warning',
      draft: 'dark',
      void: 'tertiary',
      processing: 'primary',
      paid: 'success'
    }
    color = helper[status.to_sym]
    "<span class='badge text-uppercase bg-soft-#{color} text-#{color}'>#{status}</span>".html_safe
  end

  def order_index_receipt(order)
    link_to receipts_path(order_number: order.order_number), class: 'btn d-inline-flex btn-sm btn-neutral rounded-pill' do
      "<span class='pe-3'>
        <i class='bi bi-receipt'></i>
      </span>
      <span>Invoice</span>".html_safe
    end
  end

  def order_edit_go_back
    link_to orders_path, class: 'btn d-inline-flex shadow btn-sm btn-neutral border-base me-2' do
      "<span class='pe-0 pe-lg-2'>
        <i class='bi bi-arrow-left'></i>
      </span>
      <span class='d-none d-lg-block' >Back</span>".html_safe
    end
  end

  def order_edit_status
    helper = {
      complete: 'success',
      pending: 'warning',
      draft: 'dark',
      void: 'tertiary',
      processing: 'primary',
    }
    color = helper[@order.status.to_sym]

    "<span class='badge badge-pill bg-#{color}'>#{@order.status}</span>".html_safe
  end
end
