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

  private

  def set_user
    @resource = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(
      :name,
      :email,
      :role,
      :salary
    )
  end
end
