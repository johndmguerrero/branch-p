# == Schema Information
#
# Table name: wallet_transactions
#
#  id              :bigint           not null, primary key
#  amount_cents    :integer          default(0), not null
#  amount_currency :string           default("PHP"), not null
#  remarks         :string
#  status          :integer
#  type            :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  user_id         :bigint
#  wallet_id       :bigint
#
# Indexes
#
#  index_wallet_transactions_on_user_id    (user_id)
#  index_wallet_transactions_on_wallet_id  (wallet_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#  fk_rails_...  (wallet_id => wallets.id)
#
module WalletTransactions
  class Deposit < WalletTransaction

    monetize :amount_cents

    def complete!
      return complete? if complete?
      wallet.update(balance_cents: wallet.balance_cents = wallet.balance_cents + amount_cents)
      super
    end
  end
end
