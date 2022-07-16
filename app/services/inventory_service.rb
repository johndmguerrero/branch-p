class InventoryService
  attr_accessor :params, :inventory, :inventory_item, :processed, :message, :url, :branch, :user
  include Rails.application.routes.url_helpers

  def initialize(options = {})
    self.params           = options[:params]
    self.inventory        = options[:inventory]
    self.inventory_item   = options[:inventory_item]
    self.branch           = options[:branch]
    self.user             = options[:user]
    self.processed        = false
    self.url              = '/'
    self.message          = nil
  end

  def add_inventory
    add_inventory = Inventory.new(params)
    add_inventory.branch = branch
    add_inventory.user = user

    if add_inventory.save
      self.url = edit_inventory_path(id: add_inventory.id)
      self.message = { notice: 'Inventory Processed' }
    else
      self.url = inventories_path
      self.message = { alert: add_inventory.errors.full_messages }
    end
  end

  def approve_inventory
    if inventory.complete!
      self.url = inventories_path
      self.message = { notice: 'Inventory Complete' }
    else
      self.url = inventories_path
      self.message = { alert: 'Something went wrong' }
    end
  end

  def void_inventory
    inventory.void_remarks = params
    if inventory.void!
      self.url = edit_inventory_path(id: inventory.id)
      self.message = { notice: 'Inventory Voided!' }
    else
      self.url = edit_inventory_path(id: inventory.id)
      self.message = { alert: 'Something went wrong' }
    end
  end

  def cancel_inventory
    if inventory.cancel!
      self.url = inventories_path
      self.message = { notice: 'Inventory Cancel' }
    else
      self.url = inventories_path
      self.message = { alert: 'Something went wrong' }
    end
  end
end