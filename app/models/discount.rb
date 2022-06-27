# == Schema Information
#
# Table name: discounts
#
#  id                :bigint           not null, primary key
#  amount_cents      :integer          default(0), not null
#  amount_currency   :string           default("PHP"), not null
#  discountable_type :string
#  off_type          :integer
#  percent           :float
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  discountable_id   :bigint
#
# Indexes
#
#  index_discounts_on_discountable  (discountable_type,discountable_id)
#
class Discount < ApplicationRecord
  enum off_type: [:amount, :percent], _default: 'amount'

  belongs_to :discountable, polymorphic: true

  monetize :amount_cents
end
