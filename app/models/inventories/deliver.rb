# == Schema Information
#
# Table name: inventories
#
#  id               :bigint           not null, primary key
#  inventory_number :string
#  origin           :string
#  remarks          :string
#  status           :integer
#  type             :string
#  void_remarks     :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  branch_id        :bigint
#  user_id          :bigint
#
# Indexes
#
#  index_inventories_on_branch_id  (branch_id)
#  index_inventories_on_user_id    (user_id)
#
module Inventories
  class Deliver < Inventory

    def complete!
      inventory_items.each do |item|
        product = item.product
        product.update(quantity: product.quantity + item.quantity)
        item.complete!
      end

      super
    end

    def void!
      inventory_items.each do |item|
        product = item.product
        product.update(quantity: product.quantity - item.quantity)
        item.void!
      end

      super
    end

  end
end
