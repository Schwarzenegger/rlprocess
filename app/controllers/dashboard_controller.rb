class DashboardController < ApplicationController
  before_action :authenticate_user!

  def index
    if current_user.admin?
      @q = Activity.includes(:master_activity, :client, :user).ransack(params[:q])
    else
      @q = Activity.includes(:master_activity, :client).where(user_id: current_user).ransack(params[:q])
    end

    @q.sorts = ['status asc', 'deadline asc'] if @q.sorts.empty?

    @activities = @q.result
  end

end
