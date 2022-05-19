module OrderConcern
  extend ActiveSupport::Concern

  included do
    monetize :subtotal_cents, :total_cents
  end
end