class SettingsController < ApplicationController
  before_action :authenticate_user!

  def index

  end

  def update_store_time
    current_branch.update(update_time_params)

    redirect_to settings_path, flash: { notice: 'Store Time Updated' }
  rescue
    redirect_to settings_path, flash: { alert: 'Something Went Wrong' }
  end

  private

  def update_time_params
    params.require(:branch).permit(:opens_at, :close_at)
  end
end
