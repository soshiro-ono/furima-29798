class OrdersController < ApplicationController
  def index
    @item = Item.find(params[:item_id])
    @order = Order.new
  end

  def new
    # @order_address = Order_address.new   
    @order_address = OrderAddress.new   

  end

  def create
    # binding.pry
    @item = Item.find(params[:item_id])
    @order_address = OrderAddress.new(order_params)
    if @order_address.valid?
      Payjp.api_key = "sk_test_15d1bc4a41863e6a7dd762f5"  # 自身のPAY.JPテスト秘密鍵を記述しましょう
      Payjp::Charge.create(
        amount: @item.price,  # 商品の値段がないから決済できない？だとするとorder_paramsにitemの情報が必要？
        card: order_params[:token],    # カードトークンここの書き方がおかしい？
        currency: 'jpy'               # 通貨の種類（日本円）
      )
      @order_address.save
      redirect_to root_path
    else
      render action: :new
    end
  end

  private

  def order_params
    params.permit(:item_id, :postal_code, :prefectures_id, :municipality, :address, :building, :phone, :token).merge(user_id: current_user.id)
  end

  # def order_params
  #   params.require(:item).permit(:name,:description,:category_id,:status_id,:delivery_charge_id,:area_id,:days_id,:price,:image).merge(user_id: current_user.id, item_id: params[:item_id])
  # end

  # def order_params
  #   params.require(:address).permit(:postal_code, :prefectures_id,:municipality, :address, :building, :phone).merge(token: params[:token])
  # end

  
end

# params.permit(:postal_code, :prefecture_id)
# {"postal_code"=>"123-1234", "prefectures_id"=>"3", "municipality"=>"ああ区", "address"=>"青山１−１−１", "building"=>"", "phone"=>"09087876564", "token"=>"tok_3ceff4e2bd37713144786cdeccd0", "controller"=>"orders", "action"=>"create", "item_id"=>"1"} 

# params.permit(:postal_code,:prefectures_id)
# {"postal_code" => "123-1234", "prefecutures_id" => "3"}

# なぜorderとaddressでテーブルをわけたのか？
# 分けなくてもできることはできるらしいが分けた方がわかりやすいらしい

