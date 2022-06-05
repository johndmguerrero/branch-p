module WalletConcern
  extend ActiveSupport::Concern

  included do
    monetize :balance_cents
  end
end