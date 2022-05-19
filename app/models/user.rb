# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  account_number         :string
#  address                :string
#  current_sign_in_at     :datetime
#  current_sign_in_ip     :string
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  first_name             :string
#  last_name              :string
#  last_sign_in_at        :datetime
#  last_sign_in_ip        :string
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  role                   :integer
#  sign_in_count          :integer          default(0), not null
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  branch_id              :bigint
#
# Indexes
#
#  index_users_on_branch_id             (branch_id)
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#
class User < ApplicationRecord
  default_scope { includes(:branch, :orders) }

  enum role: [ :staff, :admin, :owner], _default: 'staff'
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  belongs_to :branch
  
  has_many :orders

  def avatar_name
    email.chars.first
  end

  def user_name
    if owner?
      'Owner'
    elsif admin?
      'Admin'
    else
      'Staff'
    end
  end
end
