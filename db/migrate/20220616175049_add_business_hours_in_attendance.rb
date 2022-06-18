class AddBusinessHoursInAttendance < ActiveRecord::Migration[7.0]
  def change
    change_table :attendances do |t|
      t.time :branch_opening_time
      t.time :branch_closing_time
      t.time :stamp
    end
  end
end
