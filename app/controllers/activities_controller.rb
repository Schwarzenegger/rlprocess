class ActivitiesController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource
  before_action :set_activity, only: [:update, :show, :start,
                :finish, :restart, :archive]

  respond_to :js

  def new
    @resource = MasterActivity.new
    @resource.activities.build
    respond_with(@resource)
  end

  def create
    @resource = MasterActivity.new(master_activity_params)
    @resource.frequency = 4
    @resource.activities.first.deadline = @resource.deadline_date
    @resource_valid = @resource.save
    @location = dashboard_path

    if @resource_valid
      flash[:notice] = t('flash.actions.create.notice', resource_name: t('activerecord.models.activity'))
    end
    respond_with(@resource)
  end

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

  def master_activity_params
    params.require(:master_activity).permit(
      :name,
      :category,
      :deadline_date,
      :has_checkbox,
      :checkbox_options,
      :competence,
      :start_date,
      deadline_month: [],
      master_checklist_options_attributes: [:id, :name, :_destroy],
      activities_attributes: [:id, :client_id, :user_id]
      )
  end

  def set_activity
    @resource = Activity.find(params[:id])
  end
end
