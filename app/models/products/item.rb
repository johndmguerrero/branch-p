# == Schema Information
#
# Table name: products
#
#  id             :bigint           not null, primary key
#  cost_cents     :integer          default(0), not null
#  cost_currency  :string           default("PHP"), not null
#  deleted_at     :datetime
#  description    :string
#  name           :string
#  price_cents    :integer          default(0), not null
#  price_currency :string           default("PHP"), not null
#  quantity       :integer          default(0)
#  status         :integer
#  type           :string
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  branch_id      :bigint
#  category_id    :bigint
#
# Indexes
#
#  index_products_on_branch_id    (branch_id)
#  index_products_on_category_id  (category_id)
#  index_products_on_deleted_at   (deleted_at)
#
module Products
  class Item < Product
    belongs_to :category, class_name: 'Categories::Item', foreign_key: 'category_id'
    
  end
end
