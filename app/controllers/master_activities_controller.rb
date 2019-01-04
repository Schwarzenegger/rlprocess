class MasterActivitiesController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource
  before_action :set_master_activity, only: [:edit, :update, :destroy]

  respond_to :html, only: [:index]
  respond_to :js, except: [:index]

  def index
    @q = MasterActivity.search(params[:q])
    @resources = @q.result.page(params[:page])
  end

  def new
    @resource = MasterActivity.new
    respond_with(@resource)
  end

  def create
    @resource = MasterActivity.new(master_activity_params)
    @resource_valid = @resource.save
    @location = master_activities_path

    if @resource_valid
      flash[:notice] = t('flash.actions.create.notice', resource_name: t('activerecord.models.master_activity'))
    end
    respond_with(@resource)
  end

  def edit
    respond_with(@resource)
  end

  def update
    @resource_valid = @resource.update(master_activity_params)

    @location = master_activities_path

    if @resource_valid
      flash[:notice] = t('flash.actions.update.notice', resource_name: t('activerecord.models.master_activity'))
    end
    respond_with(@resource)
  end

  def destroy
    if @resource.destroy
      flash[:alert] = t('flash.actions.destroy.notice', resource_name: t('activerecord.models.master_activity'))
      redirect_to master_activities_path
    else
      flash[:alert] = t('activerecord.errors.models.master_activity.delete')
      redirect_to master_activities_path
    end
  end

  private

  def set_master_activity
    @resource = MasterActivity.find(params[:id])
  end

  def master_activity_params
    params.require(:master_activity).permit(
      :name,
      :category,
      :frequency,
      :deadline_year,
      :deadline_month,
      :deadline_day,
      :has_checkbox,
      :checkbox_options
    )
  end
end
