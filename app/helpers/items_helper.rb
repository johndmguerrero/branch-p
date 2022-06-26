module ItemsHelper

  def items_index_view
    if @items.present?
      render partial: 'items/partials/table'
    else
      render partial: 'items/placeholders/table'
    end
  end

  def item_go_back_index
    link_to items_path, class: 'btn d-inline-flex shadow btn-sm btn-neutral border-base me-2' do
      "<span class='pe-0 pe-lg-2'>
        <i class='bi bi-arrow-left'></i>
      </span>
      <span class='d-none d-lg-block' >Back</span>".html_safe
    end
  end

  def item_index_table_name(item)
    if !item.deleted?
      link_to edit_item_path(item.id), class: 'd-inline-flex text-semibold' do
        "<span>#{item.name}</span>".html_safe
      end
    else
      item.name
    end
  end

  def item_edit_image_display
    if @item&.image&.present?
      "<div data-item-target='itemCard' class='bg-cover rounded-1 shadow' style='height: 250px; background-image: url(#{url_for(@item.image)}); background-position: center center;'></div>".html_safe
    else
      "<div data-item-target='itemCard' class='bg-cover rounded-1 shadow' style='height: 250px; background-image: url(https://images.unsplash.com/photo-1602161571105-1655a1c114a6?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1280&q=80); background-position: center center;'></div>".html_safe
    end
  end

  def item_set_status_btn
    if @item.active?
      button_to archive_item_path(@item.id), method: :post, class: 'btn shadow d-inline-flex btn-sm btn-neutral border-base mx-1', form_class: 'd-inline-flex' do
        "<span class=' pe-2'>
          <i class='bi bi-square'></i>
        </span>
        <span>Set Archive</span>".html_safe
      end
    else
      button_to active_item_path(@item.id), method: :post, class: 'btn shadow d-inline-flex btn-sm btn-neutral border-base mx-1', form_class: 'd-inline-flex' do
        "<span class=' pe-2'>
          <i class='bi bi-check-square'></i>
        </span>
        <span>Set Active</span>".html_safe
      end
    end
  end

  def item_delete_btn
    button_to item_path(@item.id), method: :delete, class: 'btn shadow d-inline-flex btn-sm btn-outline-danger mx-1', form_class: 'd-inline-flex', form: { id: 'nice' } do
      "<span class=' pe-2'>
        <i class='bi bi-trash'></i>
      </span>
      <span>Remove</span>".html_safe
    end
  end

  def items_status(status)
    product_status = {
      active: 'success',
      # inactive: 'secondary',
      archived: 'secondary'
    }

    helper = product_status[status.to_sym]

    "<span class='badge rounded-pill bg-soft-#{helper} text-#{helper}'>#{status}</span>".html_safe
  end
end
