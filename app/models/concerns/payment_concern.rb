module PaymentConcern
  extend ActiveSupport::Concern

  included do
    monetize :amount_paid_cents, :change_cents
  end
end