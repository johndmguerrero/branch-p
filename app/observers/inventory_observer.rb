class InventoryObserver < ActiveRecord::Observer

  def after_initialize(inventory)
    inventory.inventory_number ||= generate_number(inventory)
  end

  def before_create(inventory)
    inventory.type ||= 'Inventory'
  end

  def after_create(inventory)
    if inventory.user.owner?
      inventory.complete!
    end
  end

  private

  def generate_number(inventory)
    inventory_number = loop do
      inventory_number = "in_#{SecureRandom.hex(3).upcase}"
      break inventory_number unless inventory.class.exists? inventory_number: inventory_number
    end

    inventory_number
  end

end