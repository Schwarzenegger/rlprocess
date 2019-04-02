class ActivitiesController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource
  before_action :set_activity, only: [:update, :show, :start,
                :finish, :restart, :archive]

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

  def show
    respond_with(@resource)
  end

  def mark_option
    acl = ActivityCheckList.find(params[:optionId])
    acl.done = params[:checked]
    acl.save
  end

  def start
    @resource.start
  end

  def finish
    if @resource.has_done_all_checklists?
      @resource.finish
    end
  end

  def restart
    @resource.restart
  end

  def archive
    @resource.archive
  end

  private

  def set_activity
    @resource = Activity.find(params[:id])
  end
end
