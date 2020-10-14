class OrdersController < ApplicationController
  # before_action :move_to_index
  before_action :authenticate_user!
  # この記述でログインしていないユーザーは直接購入ページにきてもログインページに飛ばす

  def index
    @item = Item.find(params[:item_id])
    @order_address = OrderAddress.new   
  end


  def create
    @item = Item.find(params[:item_id])
    @order_address = OrderAddress.new(order_params)
    if @order_address.valid?
      pay_item
      @order_address.save
      redirect_to root_path
    else
      render action: :index
    end
  end

  private

  def order_params
    params.permit(:item_id, :postal_code, :prefectures_id, :municipality, :address, :building, :phone, :token).merge(user_id: current_user.id)
    # なぜmerge(user_id: current_user.id)にするのか。OrderAddressのattr_accessorでuser_idを読み込むことができるようにしている。paramsの中身に含まれてないものはマージで送るらしい
  end

  def pay_item
    Payjp.api_key = "sk_test_15d1bc4a41863e6a7dd762f5"  # 自身のPAY.JPテスト秘密鍵を記述しましょう
    Payjp::Charge.create(
      amount: @item.price,  # 商品の値段がないから決済できない？だとするとorder_paramsにitemの情報が必要？
      card: order_params[:token],    # カードトークンここの書き方がおかしい？
      currency: 'jpy'               # 通貨の種類（日本円）
    )
  end

  # def move_to_index
  #   if user_id == current_user.id
  #     redirect_to root_path
  #   end
  # end
  # 出品者が購入ページに行こうとするとindexに戻す
end

# なぜorderとaddressでテーブルをわけたのか？
# 分けなくてもできることはできるらしいが分けた方がわかりやすいらしい

