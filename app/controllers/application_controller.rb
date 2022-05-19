class ApplicationController < ActionController::Base
  helper_method :current_branch

  private

  def current_order

  end

  def current_branch
    @current_branch ||= current_user.branch
  end
end
