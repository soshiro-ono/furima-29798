class ItemsController < ApplicationController
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
      render :new
    end
  end

  def input
    post = Post.find(params[:id])
    if post.input
      post.update(input: false)
    else
      post.update(input: true)
    end

    item = Post.find(params[:id])
    render json: { post: item }
  end

  private

  def item_params
    params.require(:item).permit(:name,:description,:category_id,:status_id,:delivery_charge_id,:area_id,:days_id).merge(user_id: current_user_id)
  end
end
