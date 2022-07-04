# == Schema Information
#
# Table name: inventory_items
#
#  id           :bigint           not null, primary key
#  damaged      :integer
#  quantity     :integer
#  status       :integer
#  undelivered  :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  inventory_id :bigint
#  product_id   :bigint
#
# Indexes
#
#  index_inventory_items_on_inventory_id  (inventory_id)
#  index_inventory_items_on_product_id    (product_id)
#
class InventoryItem < ApplicationRecord
  enum status: [:pending, :complete, :void], _default: 'pending'

  belongs_to :inventory
  belongs_to :product, with_deleted: true

  
end
