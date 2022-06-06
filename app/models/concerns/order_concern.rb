module OrderConcern
  extend ActiveSupport::Concern

  included do
    self.per_page = 10
    monetize :subtotal_cents, :total_cents

    def order_total_quantity
      order_items.map(&:quantity).sum
    end

    def order_discount
      0
    end

    def recalculate
      self.subtotal_cents = order_items.map(&:recalculate).sum
      self.total_cents = subtotal_cents if true # add discount condition here
      save!
    end

    def paid?
      payment.paid?
    end

    def empty_cart?
      order_total_quantity <= 0
    end
  end
end