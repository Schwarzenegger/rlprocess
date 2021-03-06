class ClientsController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource
  before_action :set_client, only: [:edit, :update,
                  :destroy, :link_activities, :get_to_link, :get_to_payment]

  respond_to :html
  respond_to :js, only: [:edit, :handle_profile_change]

  def index
    @q = Client.search(params[:q])
    @q.sorts = 'social_name asc' if @q.sorts.empty?
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

  def show
    @resource = Client.with_attached_uploads.find(params[:id])

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

  def destroy
    begin
      @resource.destroy
      flash[:alert] = t('flash.actions.destroy.notice', resource_name: t('activerecord.models.client'))
      redirect_to clients_path
    rescue
      flash[:alert] = t('activerecord.errors.models.client.delete')
      redirect_to clients_path
    end
  end

  def delete_attachment
    @client = Client.find(params[:client_id])
    @client.uploads.find(params[:attachment_id]).purge
    respond_with(@client)
  end

  def link_activities
    @resource_valid = @resource.update(client_params)

    @location = clients_path

    if @resource_valid
      ActivityWorker.perform_async(@resource.client_user_activities.ids)
      flash[:notice] = t('flash.actions.update.notice', resource_name: t('activerecord.models.master_activity'))
    end
  end

  def handle_profile_change
    if !params['selected_id'].blank?
      @add_more = true
      @activity_profile = ActivityProfile.find(params['selected_id'])
    elsif !params['deselected_id'].blank?

    end
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
      :nickname,
      :partner_name,
      :partner_cpf,
      :payment_frequency,
      :observations,
      activity_profile_ids: [],
      uploads: [],
      client_user_activities_attributes: [:id, :client_id, :master_activity_id, :user_id, :_destroy]
    )
  end
end
