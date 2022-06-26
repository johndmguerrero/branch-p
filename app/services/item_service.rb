class ItemService
  attr_accessor :item, :params, :processed, :message, :url, :branch
  include Rails.application.routes.url_helpers

  def initialize(options = {})
    self.item       = options[:item]
    self.params     = options[:params]
    self.processed  = false
    self.message    = nil
    self.url        = '/'
    self.branch     = options[:branch]
  end
  
  def add_item
    add_item = Product.new(params)
    add_item.branch = branch
    if add_item.save
      self.url = edit_item_path(add_item.id)
      self.message = { notice: 'Item Created!' }
    else
      self.url = items_path
      self.message = { alert: add_item.errors.full_messages}
    end
  end

  def update_item
    if item.update(params)
      self.url = edit_item_path(item.id)
      self.message = { notice: 'Item Updated!' }
    else
      self.url = edit_item_path(item.id)
      self.message = { alert: item.errors.full_messages }
    end
  end

  def delete_item
    if item.destroy
      self.url = items_path
      self.message = { notice: "item #{item.name} deleted" }
    else
      self.url = edit_item_path(item.id)
      self.message = { alert: item.errors.full_messages }
    end
  end
end