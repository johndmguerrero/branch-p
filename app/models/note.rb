# == Schema Information
#
# Table name: notes
#
#  id           :bigint           not null, primary key
#  message      :string
#  notable_type :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  notable_id   :bigint
#  user_id      :bigint
#
# Indexes
#
#  index_notes_on_notable  (notable_type,notable_id)
#  index_notes_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class Note < ApplicationRecord
  belongs_to :notable, polymorphic: true
  belongs_to :user
end
