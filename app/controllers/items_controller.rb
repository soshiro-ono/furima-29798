class ItemsController < ApplicationController
  # before_action :move_to_index, except: [:index]
  before_action :authenticate_user!,except: [:index]
  
  def index
    @items = Item.all.order("created_at DESC")
  end

  def new
    @item = Item.new
  end
  

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      # redirect_to new_item_path
      render :new
      # このrenderの意味は？
    end
  end

  private

  def item_params
    params.require(:item).permit(:name,:description,:category_id,:status_id,:delivery_charge_id,:area_id,:days_id,:price,:image).merge(user_id: current_user.id)
  end

  # def move_to_index
  #   unless user_signed_in?
  #     redirect_to action: :index
  #   end
  # end
end
