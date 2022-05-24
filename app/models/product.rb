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
class Product < ApplicationRecord
  # default_scope { includes(:category) }
  include ProductConcern
  acts_as_paranoid

  enum status: [:active, :archived], _default: 'active'

  belongs_to :branch
  belongs_to :category, class_name: 'Categories::Product'

  has_one_attached :image

  scope :deleted, -> { self.only_deleted }
  scope :archived, -> { where(status: [:archived]) }

  def thumbnail_image
    image.variant(resize: '256x256!')
  end
end
