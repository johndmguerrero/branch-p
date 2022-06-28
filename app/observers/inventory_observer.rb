class InventoryObserver < ActiveRecord::Observer

  def before_create(inventory)
    inventory.type ||= 'Inventory'
  end
end