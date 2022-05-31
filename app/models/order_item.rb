# == Schema Information
#
# Table name: order_items
#
#  id                :bigint           not null, primary key
#  quantity          :integer          default(0)
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
  default_scope { includes(:product).order('id desc') }

  include OrderItemConcern

  enum status: [:pending, :void, :complete], _default: "pending"

  belongs_to :order
  belongs_to :product, with_deleted: true

  def complete_transaction
    return true if complete?
    product.update(quantity: product.quantity - quantity)
    complete!
  end

  def revert_transaction
    return true if void?
    product.update(quantity: product.quantity + quantity)
    void!
  end
end
