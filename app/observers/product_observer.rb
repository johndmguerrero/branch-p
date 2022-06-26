class ProductObserver < ActiveRecord::Observer

  def before_create(product)
    product.type ||= 'Product'
  end

end