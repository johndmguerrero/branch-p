module ProductConcern
  extend ActiveSupport::Concern

  included do
    self.per_page = 25
    validates_uniqueness_of :name
    monetize :price_cents, :cost_cents
  end
end