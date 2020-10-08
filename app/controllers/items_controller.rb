class ItemsController < ApplicationController
  before_action :authenticate_user!,except: [:index,:show]

  def index
    @items = Item.all.order("created_at DESC")
  end

  def new
    @item = Item.new
  end

  def show
    # @item = Item.find(item_params)これだとどの情報を持ってきていいのか分からなくてエラーになる。params[:id]にはPrefixで指定したパスであるitem_path(item.id)のitem.idにあたる数字。クリックしたitem.idが@itemに入る
    @item = Item.find(params[:id])
  end

  def edit
  end
  

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new
    end
  end

  private

  def item_params
    params.require(:item).permit(:name,:description,:category_id,:status_id,:delivery_charge_id,:area_id,:days_id,:price,:image).merge(user_id: current_user.id)
  end
end
