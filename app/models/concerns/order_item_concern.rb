module OrderItemConcern
  extend ActiveSupport::Concern

  included do

    monetize :subtotal_cents, :total_cents, :purchasing_price_cents
    
    def subtotal_per_quantity
      quantity * purchasing_price_cents
    end

    def recalculate
      self.subtotal_cents = subtotal_per_quantity
      validate_discount
      self.total_cents = subtotal_cents if !discount.present?
      total_cents
    end

    def validate_discount
      if discount.present?
        if discount.percent?
          self.total_cents = subtotal_cents - ( subtotal_cents * discount.percent / 100 )
        else discount.amount?
          self.total_cents = subtotal_cents - discount.amount_cents
        end
    
        self.total_cents = 0 if total_cents.negative?
      end
    end
  end

  def remove_discount!
    if discount.present?
      discount.destroy
    end
  end

  def apply_discount(type:, amount:)
    discount = build_discount
    discount.off_type = type.to_sym
    if discount.percent?
      discount.percent = amount
    elsif discount.amount?
      discount.amount = amount
    end
    discount.save
  end

end