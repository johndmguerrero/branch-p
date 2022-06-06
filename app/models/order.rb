# == Schema Information
#
# Table name: orders
#
#  id                :bigint           not null, primary key
#  completed_at      :datetime
#  order_number      :string
#  remarks           :string
#  status            :integer
#  subtotal_cents    :integer          default(0), not null
#  subtotal_currency :string           default("PHP"), not null
#  total_cents       :integer          default(0), not null
#  total_currency    :string           default("PHP"), not null
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  branch_id         :bigint
#  user_id           :bigint
#
# Indexes
#
#  index_orders_on_branch_id  (branch_id)
#  index_orders_on_user_id    (user_id)
#
class Order < ApplicationRecord
  default_scope { order('created_at desc') }
  include OrderConcern

  enum status: [:pending, :draft, :void, :processing, :complete], _default: 'pending'

  belongs_to :user
  belongs_to :branch, optional: true

  has_one :payment
  has_many :order_items, dependent: :destroy
  has_many :notes, as: :notable

  def complete!(wallet:)
    order_items.map(&:complete_transaction)
    completed_at = Time.now
    self.status = :complete
    WalletTransactions::Order.create(
      amount_cents: total_cents,
      remarks: "complete order #{order_number}",
      user: user,
      wallet: wallet
    )
    save
  end

  def void_order(by:, message:)
    order_items.map(&:revert_transaction)
    notes.create(message: message, user: by)
    void!
  end
end
