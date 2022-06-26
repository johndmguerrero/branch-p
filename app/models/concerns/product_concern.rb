module ProductConcern
  extend ActiveSupport::Concern

  included do
    self.per_page = 25
    monetize :price_cents, :cost_cents
  end
end