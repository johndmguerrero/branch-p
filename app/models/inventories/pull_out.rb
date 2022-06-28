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
  class PullOut < Inventory
    
  end
end
