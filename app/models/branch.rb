# == Schema Information
#
# Table name: branches
#
#  id         :bigint           not null, primary key
#  address    :string
#  name       :string
#  status     :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Branch < ApplicationRecord
  has_many :users
  enum status: [:open, :close], _default: "close"

  def open!
    p "nice"
    super 
  end

  def initials
    name[0,1]
  end
end
