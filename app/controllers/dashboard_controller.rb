class DashboardController < ApplicationController
  before_action :authenticate_user!

  def index
    if current_user.admin?
      activities = Activity.includes(:master_activity, :client, :user).all.order(:deadline)
    else
      activities = Activity.includes(:master_activity, :client).where(user_id: current_user).order(:deadline)
    end

    @todo = activities.todo
    @doing = activities.doing
    @done = activities.done

  end

end
