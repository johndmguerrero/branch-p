class StaffsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_staff, only: [:edit, :update, :update_password, :active, :archive]
  before_action :void_staff_access

  def index
    @staffs = User.where(role: [:admin, :staff]).paginate(page: params[:page])
    @generate_password = SecureRandom.hex(4)
  end

  def create
    user = User.new(staff_params)
    user.branch = current_branch

    if user.save
      redirect_to staffs_path, flash: { notice: 'Successfully created' }
    else
      redirect_to staffs_path, flash: { alert: user.errors.full_messages }
    end
  end

  def edit
    @attendances = @staff.attendances.paginate(page: params[:page])
  end

  def update
    @staff.update(update_params)

    redirect_to edit_staff_path(@staff.id), flash: { notice: 'Staff set to Archive' }
  end

  def archive
    @staff.archive!

    redirect_to edit_staff_path(@staff.id), flash: { notice: 'Staff set to Archive' }
  end

  def active
    @staff.active!

    redirect_to edit_staff_path(@staff.id), flash: { notice: 'Staff set to Active' }
  end

  def update_password
    @staff.update(password_params)

    redirect_to edit_staff_path(@staff.id), flash: { notice: 'Password sucessfully updated' }
  end

  private

  def staff_params
    params.require(:staff).permit(:address, :email, :first_name, :last_name, :password, :password_confirmation, :role)
  end

  def update_params
    params.require(:staff).permit(:address, :first_name, :last_name, :role)
  end

  def password_params
    params.require(:security).permit(:password, :password_confirmation)
  end

  def set_staff
    @staff = User.find_by id: params[:id]
  end

end
