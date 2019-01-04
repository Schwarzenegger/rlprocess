class UsersController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource
  before_action :set_user, only: [:edit, :update, :destroy]

  respond_to :html, only: [:index]
  respond_to :js, except: [:index]

  def index
    @q = User.search(params[:q])
    @resources = @q.result.page(params[:page])
  end

  def new
    @resource = User.new
    respond_with(@resource)
  end

  def create
    @resource = User.new(user_params)
    @resource_valid = @resource.save
    @location = users_path

    if @resource_valid
      flash[:notice] = t('flash.actions.create.notice', resource_name: t('activerecord.models.user'))
    end
    respond_with(@resource)
  end

  def edit
    respond_with(@resource)
  end

  def update
    if params[:user][:password].blank?
      @resource_valid = @resource.update_without_password(user_params)
    else
      @resource_valid = @resource.update(user_params)
    end

    @location = users_path

    if @resource_valid
      flash[:notice] = t('flash.actions.update.notice', resource_name: t('activerecord.models.user'))
    end
    respond_with(@resource)
  end

  def destroy
    if @resource.destroy
      flash[:alert] = t('flash.actions.destroy.notice', resource_name: t('activerecord.models.user'))
      redirect_to users_path
    else
      flash[:alert] = t('activerecord.errors.models.user.delete')
      redirect_to users_path
    end
  end

  private

  def set_user
    @resource = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(
      :name,
      :email,
      :role,
      :salary,
      :password
    )
  end
end
