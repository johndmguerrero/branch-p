class ProfilesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: [:stamp, :reset_password, :update]

  def index
    @attendances = current_user.attendances.paginate(page: params[:page])
  end

  def update
    @user.update(user_params)

    redirect_to profiles_path, flash: { notice: "User updated succesfully" }
  end

  def stamp
    @user.stamp_attendance message: stamp_params[:remarks]
    @user.reload

    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: [
          turbo_stream.update("stamp", partial: 'profiles/partials/stamp_form', locals: { user: current_user }),
          turbo_stream.update("attendance_table", partial: 'profiles/partials/attendances_tables', locals: { attendances: current_user.attendances.paginate(page: params[:page]) })
        ]
      end
    end
  end

  def reset_password

  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name)
  end

  def stamp_params
    params.require(:attendance).permit(:remarks)
  end

  def set_user
    @user = User.find_by id: params[:id]
  end
end
