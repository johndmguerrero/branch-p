class ProductService
  attr_accessor :product, :params, :processed, :message, :url, :branch
  include Rails.application.routes.url_helpers

  def initialize(options = {})
    self.product    = options[:product]
    self.params     = options[:params]
    self.processed  = false
    self.message    = nil
    self.url        = '/'
    self.branch     = options[:branch]
  end
  
  def add_product
    add_product = Product.new(params)
    add_product.branch = branch
    if add_product.save
      self.url = edit_product_path(add_product.id)
      self.message = { notice: 'Product Created!' }
    else
      self.url = products_path
      self.message = { alert: add_product.errors.full_messages}
    end
  end

  def update_product
    if product.update(params)
      self.url = edit_product_path(product.id)
      self.message = { notice: 'Product Updated!' }
    else
      self.url = edit_product_path(product.id)
      self.message = { alert: product.errors.full_messages }
    end
  end

  def delete_product
    if product.destroy
      self.url = products_path
      self.message = { notice: "Product #{product.name} deleted" }
    else
      self.url = edit_product_path(product.id)
      self.message = { alert: product.errors.full_messages }
    end
  end
end