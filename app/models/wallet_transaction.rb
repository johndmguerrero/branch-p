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
class WalletTransaction < ApplicationRecord
  default_scope { order('created_at desc') }
  self.per_page = 10

  enum status: [:pending, :decline, :complete], _default: 'pending'
  enum transactions_types: [
    "WalletTransactions::Withdraw", 
    "WalletTransactions::Expense",
    "WalletTransactions::Deposit" ]

  belongs_to :wallet
  belongs_to :user
  
  has_many :notes, as: :notable

  monetize :amount_cents

  scope :today_total_expense, -> { complete.where('created_at >= ? and wallet_transactions.type = ?', Time.zone.now.beginning_of_day, "WalletTransactions::Expense") }
  scope :today_total_withdraw, -> { complete.where('created_at >= ? and wallet_transactions.type = ?', Time.zone.now.beginning_of_day, "WalletTransactions::Withdraw") }
  scope :today_total_deposit, -> { complete.where('created_at >= ? and wallet_transactions.type = ?', Time.zone.now.beginning_of_day, "WalletTransactions::Deposit") }
  scope :today_total_order, -> { complete.where('created_at >= ? and wallet_transactions.type = ?', Time.zone.now.beginning_of_day, "WalletTransactions::Order") }


  def self.types
    transactions_types.to_h { |type| [type.demodulize, type.demodulize.downcase] }
  end

  def complete!
    return complete? if complete?
    super()
  end
end
