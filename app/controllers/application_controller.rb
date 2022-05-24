class ApplicationController < ActionController::Base
  helper_method :current_branch
  helper_method :current_order

  private

  def current_order
    @current_order ||= current_user.orders.find_or_create_by(status: :pending, branch: current_branch)
  end

  def current_branch
    @current_branch ||= current_user.branch
  end
end
