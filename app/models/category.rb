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
class Category < ApplicationRecord
  include CategoryConcern

  has_many :products, class_name: 'Product', foreign_key: 'category_id'
  has_many :items, class_name: 'Products::Item', foreign_key: 'category_id'
end
