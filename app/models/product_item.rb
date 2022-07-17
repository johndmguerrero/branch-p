# == Schema Information
#
# Table name: product_items
#
#  id            :bigint           not null, primary key
#  quantity      :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  order_item_id :bigint
#  product_id    :bigint
#
# Indexes
#
#  index_product_items_on_order_item_id  (order_item_id)
#  index_product_items_on_product_id     (product_id)
#
class ProductItem < ApplicationRecord
  belongs_to :order_item, class_name: 'OrderItems::Package', foreign_key: 'order_item_id'
  belongs_to :product, with_deleted: true

  def description
    "#{product.name} - #{quantity} pc(s)"
  end

  def deduct_to_product
    product.update(quantity: product.quantity - quantity)
  end

  def reverse_to_product
    product.update(quantity: product.quantity + quantity)
  end

end
