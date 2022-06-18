class AttendanceObserver < ActiveRecord::Observer

  def before_create(attendance)
    attendance.stamp = Time.now.strftime("%H:%M")
  end

  def after_create(attendance)
    
    if attendance.time_in?
      attendance.late = true if attendance.branch_opening_time < attendance.stamp
      attendance.save
    end
  end

end