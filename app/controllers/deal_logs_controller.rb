class DealLogsController < ApplicationController
  before_action :set_item
  before_action :move_to_items_index


  def index
    @deal_log_address = DealLogAddress.new
  end

  def create

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

  def set_item
    @item = Item.find(params[:item_id])
  end

  def move_to_items_index
    if user_signed_in?
      if current_user.id == @item.user_id || @item.deal_log.present?
        redirect_to root_path
      end
    else
      redirect_to root_path
    end
  end
end
