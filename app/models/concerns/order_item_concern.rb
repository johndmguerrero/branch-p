module OrderItemConcern
  extend ActiveSupport::Concern

  included do

    monetize :subtotal_cents, :total_cents, :purchasing_price_cents
    
    def recalculate
      self.subtotal_cents = subtotal_per_quantity
      self.total_cents = subtotal_cents if true #not discounted
      total_cents
    end

    def subtotal_per_quantity
      quantity * purchasing_price_cents
    end
  end

end