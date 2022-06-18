class AddTimeSettingBranch < ActiveRecord::Migration[7.0]
  def change
    change_table :branches do |t|
      t.time :opens_at
      t.time :close_at
    end
  end
end
