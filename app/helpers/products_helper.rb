module ProductsHelper

  def product_index_view
    if @products.present?
      render partial: 'products/partials/table'
    else
      render partial: 'products/placeholders/table'
    end
  end
end
