class ItemsController < ApplicationController
  before_action :set_item, only: [:edit, :show, :update,:destroy]  
  before_action :authenticate_user!,except: [:index,:show]

  def index
    @items = Item.all.order("created_at DESC")
  end

  def new
    @item = Item.new
  end

  def show
  end

  def edit
  end

  def destroy
    if @item.destroy
      redirect_to root_path
    else
      redirect_to item_path(@item.id)
    end
  end

  def update
    # ＠マークは必要なのか。いるならどんなとき？
    # renderでeditを指定しているから必要。このeditは@itemを使っている。データが更新できればitemで何の問題もないが登録できなかった時の処理であるrender :editを使うために必要。pictweetではエラーハンドリングつまりrenderを使っていないため＠は必要なかった。ちなみにrenderではなくredirect_toを使っている場合も＠はいらない
    if @item.update(item_params)
      redirect_to root_path
    else
      render :edit
    end
  end
  

  def create
    # よくよく考えるとなぜここが@がいるのかわからない。createのhtmlがあるわけではないのに。＠なしでも登録できてしまった。なぜ必要なのか
    # renderでnewを指定しているから必要。このnewは@itemを使っている。データが保存できればitemで何の問題もないが登録できなかった時の処理であるrender :newを使うために必要。pictweetではエラーハンドリングつまりrenderを使っていないため＠は必要なかった。ちなみにrenderではなくredirect_toを使っている場合も＠はいらない
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

  def set_item
    @item = Item.find(params[:id])#edit show destoroyの処理をまとめている。例えばshowアクションが動いた時にset_itemが読み込まれるイメージ。
    # @item = Item.find(item_params)これだとどの情報を持ってきていいのか分からなくてエラーになる。params[:id]にはPrefixで指定したパスであるitem_path(item.id)のitem.idにあたる数字。クリックしたitem.idが@itemに入る
  end
end
