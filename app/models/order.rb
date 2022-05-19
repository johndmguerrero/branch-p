# == Schema Information
#
# Table name: orders
#
#  id                :bigint           not null, primary key
#  completed_at      :datetime
#  order_number      :string
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
  include OrderConcern

  enum status: [:pending, :draft, :void, :complete], _default: 'pending'

  belongs_to :user
  belongs_to :branch, optional: true

  has_many :order_items

end
