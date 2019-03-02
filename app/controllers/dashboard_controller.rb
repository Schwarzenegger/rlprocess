class DashboardController < ApplicationController
  before_action :authenticate_user!

  def index

    params[:q] ||= {}

    if params[:month].present?
      date_from_month = Date.new(Date.today.year, params[:month].to_i, 1)
      params[:q][:deadline_lteq] = date_from_month.end_of_month
      params[:q][:deadline_gteq] = date_from_month
      @month_value = params[:month].to_i
    else
      params[:q][:deadline_lteq] = Date.today.end_of_month
      params[:q][:deadline_gteq] = Date.today.beginning_of_month
      @month_value = Date.today.month
    end

    if current_user.admin?
      @q = Activity.unarchived.includes(:master_activity, :client, :user).ransack(params[:q])
    else
      @q = Activity.unarchived.includes(:master_activity, :client, :user).where(user_id: current_user).ransack(params[:q])
    end

    @q.sorts = ['status asc', 'deadline asc'] if @q.sorts.empty?

    @activities = @q.result
  end

end
