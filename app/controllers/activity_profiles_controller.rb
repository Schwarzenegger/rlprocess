class ActivityProfilesController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource
  before_action :set_activity_profile, only: [:edit, :update, :destroy]

  respond_to :html, only: [:index, :destroy]
  respond_to :js, except: [:index, :destroy]

  def index
    @q = ActivityProfile.search(params[:q])
    @resources = @q.result.page(params[:page])
  end

  def new
    @resource = ActivityProfile.new
    respond_with(@resource)
  end

  def create
    @resource = ActivityProfile.new(activity_profile_params)
    @resource_valid = @resource.save
    @location = activity_profiles_path

    if @resource_valid
      flash[:notice] = t('flash.actions.create.notice', resource_name: t('activerecord.models.activity_profile'))
    end
    respond_with(@resource)
  end

  def edit
    respond_with(@resource)
  end

  def update
    @resource_valid = @resource.update(activity_profile_params)

    @location = activity_profiles_path

    if @resource_valid
      flash[:notice] = t('flash.actions.update.notice', resource_name: t('activerecord.models.activity_profile'))
    end
    respond_with(@resource)
  end

  def destroy
    if @resource.destroy
      flash[:alert] = t('flash.actions.destroy.notice', resource_name: t('activerecord.models.activity_profile'))
      redirect_to activity_profiles_path
    else
      flash[:alert] = t('activerecord.errors.models.master_activity.delete')
      redirect_to activity_profiles_path
    end
  end

  private

  def set_activity_profile
    @resource = ActivityProfile.find(params[:id])
  end

  def activity_profile_params
    params.require(:activity_profile).permit(
      :name,
      master_activity_ids: []
    )
  end
end
