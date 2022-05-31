# == Schema Information
#
# Table name: categories
#
#  id          :bigint           not null, primary key
#  description :string
#  name        :string
#  type        :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
module Categories
  class Product < Category
    default_scope { where(type: 'Categories::Product') }

    has_many :products, class_name: 'Product'

  end
end
