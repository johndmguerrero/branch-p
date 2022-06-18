# == Schema Information
#
# Table name: branches
#
#  id         :bigint           not null, primary key
#  address    :string
#  close_at   :time
#  name       :string
#  opens_at   :time
#  status     :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Branch < ApplicationRecord
  has_many :users
  has_many :products
  has_many :orders

  has_one :wallet
  
  enum status: [:open, :close], _default: "close"

  def open!
    p "nice"
    super 
  end

  def initials
    name[0,1]
  end
end
