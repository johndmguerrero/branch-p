# == Schema Information
#
# Table name: products
#
#  id             :bigint           not null, primary key
#  cost_cents     :integer          default(0), not null
#  cost_currency  :string           default("PHP"), not null
#  description    :string
#  name           :string
#  price_cents    :integer          default(0), not null
#  price_currency :string           default("PHP"), not null
#  quantity       :integer
#  status         :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  branch_id      :bigint
#  category_id    :bigint
#
# Indexes
#
#  index_products_on_branch_id    (branch_id)
#  index_products_on_category_id  (category_id)
#
class Product < ApplicationRecord
  include ProductConcern

  enum status: [:active, :inactive], _default: 'active'

  belongs_to :branch
  belongs_to :category, class_name: 'Categories::Product'

end
