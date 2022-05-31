# == Schema Information
#
# Table name: payments
#
#  id                   :bigint           not null, primary key
#  amount_paid_cents    :integer          default(0), not null
#  amount_paid_currency :string           default("PHP"), not null
#  change_cents         :integer          default(0), not null
#  change_currency      :string           default("PHP"), not null
#  paid_at              :datetime
#  payment_method       :integer
#  remarks              :string
#  status               :integer
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  order_id             :bigint
#  transaction_id       :string
#
# Indexes
#
#  index_payments_on_order_id  (order_id)
#
# Foreign Keys
#
#  fk_rails_...  (order_id => orders.id)
#
class Payment < ApplicationRecord
  include PaymentConcern

  enum status: [ :pending, :paid], _default: 'pending'
  enum payment_method: [ :cash, :card], _default: 'cash'

  belongs_to :order

  def paid!
    self.paid_at = Time.now
    super
  end
end
