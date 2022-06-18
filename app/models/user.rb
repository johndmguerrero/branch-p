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
#  status                 :integer
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
  self.per_page = 10

  default_scope { includes(:branch) }

  enum role: [ :staff, :admin, :owner], _default: 'staff'
  enum status: [ :active, :archive], _default: 'active'
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  belongs_to :branch
  
  has_many :orders
  has_many :notes
  has_many :attendances

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

  def display_name
    if full_name.blank?
      email
    else
      full_name
    end
  end

  def full_name
    "#{first_name} #{last_name}"
  end

  def stamp_attendance(message:)
    branch.reload
    stamp = attendances.new(
      remarks: message,
      branch_closing_time: branch.close_at.strftime("%H:%M"),
      branch_opening_time: branch.opens_at.strftime("%H:%M")
    )
    stamp.state = :time_out if timed_in?
    
    stamp.save
  end

  def last_stamp
    last_stamp = attendances.order('created_at asc').last
  end

  def timed_in?
    last_stamp&.time_in?
  end

  def timed_out?
    !timed_in?
  end
end
