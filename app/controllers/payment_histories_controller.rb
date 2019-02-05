class PaymentHistoriesController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource
  before_action :set_payment_history, only: [:edit, :update, :destroy]
  respond_to :js, except: [:index]

  def new
    @resource = PaymentHistory.new(client_id: params[:client_id])
    respond_with(@resource)
  end

  def create
    @resource = PaymentHistory.new(payment_history_params)
    @resource_valid = @resource.save
    @location = clients_path

    if @resource_valid
      flash[:notice] = t('flash.actions.create.notice', resource_name: t('activerecord.models.payment_history'))
    end
    respond_with(@resource)
  end

  def edit
    respond_with(@resource)
  end

  def update
    @resource_valid = @resource.update(payment_history_params)

    @location = client_path(@resource.client_id)

    if @resource_valid
      flash[:notice] = t('flash.actions.update.notice', resource_name: t('activerecord.models.payment_history'))
    end

    respond_with(@resource)
  end

  def destroy
    location = client_path(@resource.client_id)

    if @resource.destroy
      flash[:alert] = t('flash.actions.destroy.notice', resource_name: t('activerecord.models.payment_history'))
    else
      flash[:alert] = t('activerecord.errors.models.payment_history.delete')
    end

    redirect_to location
  end

  private

  def set_payment_history
    @resource = PaymentHistory.find(params[:id])
  end

  def payment_history_params
    params.require(:payment_history).permit(
      :client_id,
      :value,
      :receipt_date
    )
  end
end
