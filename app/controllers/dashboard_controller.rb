class DashboardController < ApplicationController
  before_action :authenticate_user!

  def index

    params[:q] ||= {}

    if params[:month].present? && params[:year]
      @month_value = params[:month].to_i
      @year_value = params[:year].to_i
      date_from_month = Date.new(@year_value, @month_value, 1)
      params[:q][:deadline_lteq] = date_from_month.end_of_month
      params[:q][:deadline_gteq] = date_from_month
    else
      today = Date.today
      params[:q][:deadline_lteq] = today.end_of_month
      params[:q][:deadline_gteq] = today.beginning_of_month
      @month_value = today.month
      @year_value = today.year
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
