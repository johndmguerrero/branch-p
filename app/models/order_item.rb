# == Schema Information
#
# Table name: order_items
#
#  id                :bigint           not null, primary key
#  quantity          :integer
#  status            :integer
#  subtotal_cents    :integer          default(0), not null
#  subtotal_currency :string           default("PHP"), not null
#  total_cents       :integer          default(0), not null
#  total_currency    :string           default("PHP"), not null
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  order_id          :bigint
#  product_id        :bigint
#
# Indexes
#
#  index_order_items_on_order_id    (order_id)
#  index_order_items_on_product_id  (product_id)
#
# Foreign Keys
#
#  fk_rails_...  (order_id => orders.id)
#  fk_rails_...  (product_id => products.id)
#
class OrderItem < ApplicationRecord
  enum status: [:pending, :void, :complete], _default: "pending"

  belongs_to :order
  belongs_to :product
end
