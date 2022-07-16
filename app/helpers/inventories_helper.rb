module InventoriesHelper

  def inventory_status(status)
    badge = {
      pending: 'warning',
      cancel: 'danger',
      void: 'tertiary',
      complete: 'success'
    }
    helper = badge[status.to_sym]
    "<span class='badge badge-pill text-uppercase bg-soft-#{helper} text-#{helper}'>#{status}</span>".html_safe
  end

  def inventory_edit_go_back
    link_to inventories_path, class: 'btn d-inline-flex shadow btn-sm btn-neutral border-base me-2' do
      "<span class='pe-0 pe-lg-2'>
        <i class='bi bi-arrow-left'></i>
      </span>
      <span class='d-none d-lg-block' >Back</span>".html_safe
    end
  end

  def inventory_badge_item(item)
    helper = {
      complete: 'success',
      pending: 'warning',
      void: 'tertiary',
      cancel: 'danger'
    }

    color = helper[item.status.to_sym]
  end

  def inventory_edit_status
    helper = {
      complete: 'success',
      pending: 'warning',
      void: 'tertiary',
      cancel: 'danger'
    }
    color = helper[@inventory.status.to_sym]

    "<span class='badge badge-pill my-2 bg-soft-#{color} text-#{color}'>#{@inventory.status}</span>".html_safe
  end

  def inventory_item_edit_status(item)
    helper = {
      complete: 'success',
      pending: 'warning',
      void: 'tertiary',
    }
    color = helper[item.status.to_sym]

    "<span class='badge badge-pill my-2 bg-soft-#{color} text-#{color}'>#{item.status}</span>".html_safe
  end
end
