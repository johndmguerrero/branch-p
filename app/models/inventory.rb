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
class Inventory < ApplicationRecord
  default_scope { order("created_at desc") }
  self.per_page = 10

  enum status: [:pending, :cancel, :complete, :void], _default: 'pending'
  enum inventory_types: [
    "Inventories::Deliver",
    "Inventories::PullOut",
    "Inventories::Transfer"
  ]

  belongs_to :user
  belongs_to :branch

  has_many :inventory_items

  accepts_nested_attributes_for :inventory_items, reject_if: :all_blank

  def self.types
    inventory_types.to_h { |type| [type.demodulize.underscore.humanize, type] }
  end

  def display_type
    type.demodulize.underscore.humanize
  end

end
