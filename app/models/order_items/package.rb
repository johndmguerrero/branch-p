# == Schema Information
#
# Table name: order_items
#
#  id                        :bigint           not null, primary key
#  purchasing_price_cents    :integer          default(0), not null
#  purchasing_price_currency :string           default("PHP"), not null
#  quantity                  :integer          default(0)
#  status                    :integer
#  subtotal_cents            :integer          default(0), not null
#  subtotal_currency         :string           default("PHP"), not null
#  total_cents               :integer          default(0), not null
#  total_currency            :string           default("PHP"), not null
#  type                      :string
#  created_at                :datetime         not null
#  updated_at                :datetime         not null
#  order_id                  :bigint
#  product_id                :bigint
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
module OrderItems
  class Package < OrderItem
    default_scope { includes(:product_items) }

    include OrderItemConcern

    has_many :product_items, foreign_key: 'order_item_id'
    belongs_to :product, with_deleted: true
    belongs_to :order

    accepts_nested_attributes_for :product_items

    def package?
      true
    end
    
    def description
      product_items&.map(&:description).to_sentence
    end

    def complete_transaction
      return true if complete?
      product_items&.map(&:deduct_to_product)
      complete!
    end

    def revert_transaction
      return true if void?
      product_items&.map(&:reverse_to_product)
      void!
    end
  end
end
