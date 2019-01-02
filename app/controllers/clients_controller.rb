class ClientsController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource
  before_action :set_client, only: [:edit, :update, :destroy]

  respond_to :html, only: [:index]
  respond_to :js, except: [:index]

  def index
    @q = Client.search(params[:q])
    @resources = @q.result.page(params[:page])
  end

  def new
    @resource = Client.new
    respond_with(@resource)
  end

  def create
    @resource = Client.new(client_params)
    @resource_valid = @resource.save
    @location = clients_path

    if @resource_valid
      flash[:notice] = t('flash.actions.create.notice', resource_name: t('activerecord.models.client'))
    end
    respond_with(@resource)
  end

  def edit
    respond_with(@resource)
  end

  def update
    @resource_valid = @resource.update(client_params)

    @location = clients_path

    if @resource_valid
      flash[:notice] = t('flash.actions.update.notice', resource_name: t('activerecord.models.client'))
    end
    respond_with(@resource)
  end

  private

  def set_client
    @resource = Client.find(params[:id])
  end

  def client_params
    params.require(:client).permit(
      :cnpj,
      :social_name,
      :municipal_inscription,
      :state_inscription,
      :date_of_founding,
      :taxation,
      :contact,
      :email,
      :telephone,
      :iss_password,
      :simples_password,
      :start_accounting,
      :end_accounting,
      :honorary,
      :observations
    )
  end
end
