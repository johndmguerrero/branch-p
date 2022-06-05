# == Schema Information
#
# Table name: wallets
#
#  id               :bigint           not null, primary key
#  balance_cents    :integer          default(0), not null
#  balance_currency :string           default("PHP"), not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  branch_id        :bigint
#
# Indexes
#
#  index_wallets_on_branch_id  (branch_id)
#
# Foreign Keys
#
#  fk_rails_...  (branch_id => branches.id)
#
class Wallet < ApplicationRecord
  include WalletConcern

  belongs_to :branch
  has_many :wallet_transactions
  has_many :notes, as: :notable
end
