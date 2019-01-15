class MasterActivitiesController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource
  before_action :clean_select_multiple_params, only:[:create, :update]
  before_action :set_master_activity, only: [:edit, :update, :destroy]
  before_action :set_select_values, only:[:new, :edit, :create, :update]

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

  def clean_select_multiple_params
    if params['master_activity']['deadline_month']
      params['master_activity']['deadline_month'].reject!(&:blank?)
    end
  end

  def set_select_values
    @years = [*Date.today.year ..  Date.today.year + 3]
    @months = I18n.t('date.month_names').each_with_index.map { |month, index| [month, index + 1] }
  end

  def set_master_activity
    @resource = MasterActivity.find(params[:id])
  end

  def master_activity_params
    params.require(:master_activity).permit(
      :name,
      :category,
      :frequency,
      :deadline_date,
      :deadline_day,
      :has_checkbox,
      :checkbox_options,
      deadline_month: [],
      master_checklist_options_attributes: [:id, :name, :_destroy]
      )
  end
end
