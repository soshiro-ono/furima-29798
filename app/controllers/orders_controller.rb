class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_order, only: [:index, :create]  
  before_action :move_to_index
  # この記述でログインしていないユーザーは直接購入ページにきてもログインページに飛ばす


  def index
    @order_address = OrderAddress.new
    if @item.order.present?
      redirect_to root_path
    end
    # この@order_addressはエラーハンドリングで使うために必要
    # ここでいうindexは購入画面
  end


  def create
    @order_address = OrderAddress.new(order_params)
    if @order_address.valid?
      # @order_address.valid?とはどういう意味？
      pay_item
      @order_address.save
      return redirect_to root_path
    else
      render action: :index
    end
  end

  private

  def order_params
    # .require(:order_address)を追加した。order index.htmlのformwithでモデルを指定したため
    params.require(:order_address).permit(:item_id, :postal_code, :prefectures_id, :municipality, :address, :building, :phone, :token).merge(user_id: current_user.id,item_id: params[:item_id],token: params[:token])
    # なぜmerge(user_id: current_user.id)にするのか。OrderAddressのattr_accessorでuser_idを読み込むことができるようにしている。paramsの中身に含まれてないものはマージで送るらしい
  end

  def pay_item
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]  # 自身のPAY.JPテスト秘密鍵を記述しましょう→環境変数にする
    Payjp::Charge.create(
      amount: @item.price,  # 商品の値段がないから決済できない
      card: order_params[:token],    # カードトークン
      currency: 'jpy'               # 通貨の種類（日本円）
    )
  end

  def move_to_index
    @item = Item.find(params[:item_id])
    if @item.user_id == current_user.id
      redirect_to root_path
    end
  end
  # 出品者が購入ページに行こうとするとindexに戻す
  def set_order
    @item = Item.find(params[:item_id])
  end
end



