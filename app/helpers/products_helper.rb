module ProductsHelper

  def product_index_peso
    "<span>&#8369;</span>".html_safe
  end

  def product_index_view
    if @products.present?
      # @products = @products.try(&:with_deleted) if current_user.owner?
      render partial: 'products/partials/table'
    else
      render partial: 'products/placeholders/table'
    end
  end

  def product_go_back_index
    link_to products_path, class: 'btn d-inline-flex shadow btn-sm btn-neutral border-base me-2' do
      "<span class='pe-0 pe-lg-2'>
        <i class='bi bi-arrow-left'></i>
      </span>
      <span class='d-none d-lg-block' >Back</span>".html_safe
    end
  end

  def product_index_table_name(product)
    if !product.deleted?
      link_to edit_product_path(product.id), class: 'd-inline-flex text-semibold' do
        "<span>#{product.name}</span>".html_safe
      end
    else
      product.name
    end
  end

  def product_set_status_btn
    if @product.active?
      button_to archive_product_path(@product.id), method: :post, class: 'btn shadow d-inline-flex btn-sm btn-neutral border-base mx-1', form_class: 'd-inline-flex' do
        "<span class=' pe-2'>
          <i class='bi bi-square'></i>
        </span>
        <span>Set Archive</span>".html_safe
      end
    else
      button_to active_product_path(@product.id), method: :post, class: 'btn shadow d-inline-flex btn-sm btn-neutral border-base mx-1', form_class: 'd-inline-flex' do
        "<span class=' pe-2'>
          <i class='bi bi-check-square'></i>
        </span>
        <span>Set Active</span>".html_safe
      end
    end
  end

  def product_delete_btn
    button_to product_path(@product.id), method: :delete, class: 'btn shadow d-inline-flex btn-sm btn-outline-danger mx-1', form_class: 'd-inline-flex', form: { id: 'nice' } do
      "<span class=' pe-2'>
        <i class='bi bi-trash'></i>
      </span>
      <span>Remove</span>".html_safe
    end
  end

  def product_money_format(money)
    humanized_money_with_symbol(money)
  end

  def product_status(status)
    product_status = {
      active: 'success',
      # inactive: 'secondary',
      archived: 'secondary'
    }

    helper = product_status[status.to_sym]

    "<span class='badge rounded-pill bg-soft-#{helper} text-#{helper}'>#{status}</span>".html_safe
  end

  # edit page helpers

  def product_edit_header
    render partial: 'products/partials/edit/header'
  end

  def product_edit_image_display
    if @product&.image&.present?
      "<div data-product-target='productCard' class='bg-cover rounded-1 shadow' style='height: 250px; background-image: url(#{url_for(@product.image)}); background-position: center center;'></div>".html_safe
    else
      "<div data-product-target='productCard' class='bg-cover rounded-1 shadow' style='height: 250px; background-image: url(https://images.unsplash.com/photo-1602161571105-1655a1c114a6?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1280&q=80); background-position: center center;'></div>".html_safe
    end
  end

  def product_edit_modal_remove
    render partial: 'products/partials/confirm_delete'
  end
end
