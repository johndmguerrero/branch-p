# == Schema Information
#
# Table name: attendances
#
#  id                  :bigint           not null, primary key
#  branch_closing_time :time
#  branch_opening_time :time
#  late                :boolean          default(FALSE)
#  remarks             :string
#  stamp               :time
#  state               :integer
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  user_id             :bigint
#
# Indexes
#
#  index_attendances_on_user_id  (user_id)
#
class Attendance < ApplicationRecord
  self.per_page = 10

  enum state: [:time_in, :time_out], _default: 'time_in'

  belongs_to :user
end
