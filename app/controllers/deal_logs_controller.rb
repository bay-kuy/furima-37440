class DealLogsController < ApplicationController
  before_action :authenticate_user!, except: :index
  def index
    @item = Item.find(params[:item_id])
    @deal_log_address = DealLogAddress.new
  end

  def create
    @item = Item.find(params[:item_id])
    @deal_log_address = DealLogAddress.new(deal_log_params)
    if @deal_log_address.valid?
      @deal_log_address.save
      return redirect_to root_path
    else
      render :index
    end
  end

  private

  def deal_log_params
    params.require(:deal_log_address).permit(:postcode, :prefecture_id, :city, :numbers, :building, :telephone_number).merge(user_id: current_user.id, item_id: params[:item_id])
  end
end
