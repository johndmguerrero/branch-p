class ProductService
  attr_accessor :params, :processed, :message, :url, :branch

  def initialize(options = {})
    self.params     = options[:params]
    self.processed  = false
    self.message    = nil
    self.url        = '/'
    self.branch     = options[:branch]
  end
  
  def add_product
    product = Product.new(params)
    product.branch = branch
    if product.save
      self.url = "/products"
      self.message = { notice: 'Product Created!' }
    else
      self.url = "/products"
      self.message = { alert: product.errors.full_messages}
    end
  end
end