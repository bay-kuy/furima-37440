class DealLogsController < ApplicationController
  before_action :authenticate_user!, except: :index
  def index
    @deal_log_address = DealLogAddress.new
  end

  def create
    @deal_log_address = DealLogAddress.new(deal_log_params)
    if @deal_log_address.valid?
      @deal_log_address.save

    else
      render :index
  end

  private

  def deal_log_params
    params.require(:deal_log_address).permit(:postcode, :prefecture, :city, :numbers, :building, :telephone_number).merge(user_id: current_user.id, item_id: params[:items_id])
  end
end
