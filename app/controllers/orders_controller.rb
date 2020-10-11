class OrdersController < ApplicationController
  def index
    @item = Item.find(params[:item_id])
  
  end

  def create
    # @order = Order.new(order_params)
    # if @order.valid?
    #   @order.save
    #   return redirect_to root_path
    # else
    #   render 'index'
    # end
  end

  private
  def order_params
    params.require(:item).permit(:name,:description,:category_id,:status_id,:delivery_charge_id,:area_id,:days_id,:price,:image).merge(user_id: current_user.id, item_id: params[:item_id])
  end
end



# なぜorderとaddressでテーブルをわけたのか？
# 分けなくてもできることはできるらしいが分けた方がわかりやすいらしい