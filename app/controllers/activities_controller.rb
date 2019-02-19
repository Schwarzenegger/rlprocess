class ActivitiesController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource
  before_action :set_activity, only: [:update]

  respond_to :js


  def update
    case params[:destination]
    when 'todo'
      if !@resource.todo?
        @resource.restart
      end
    when 'inprogress'
      if !@resource.doing?
        @resource.start
      end
    when 'completed'
      if !@resource.done?
        @resource.finish
      end
    end
  end

  private

  def set_activity
    @resource = Activity.find(params[:id])
  end
end
