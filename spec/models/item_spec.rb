require 'rails_helper'
describe Item do
  before do
    @item = FactoryBot.build(:item)
  end

  describe '商品出品' do
    context '商品出品がうまくいくとき' do
      it "image,name,description,category_id,status_id,delivery_charge_id,area_id,days_id,priceが存在すれば登録できる" do
        expect(@item).to be_valid
      end

      it "priceが300円以上かつ9999999円以下であれば登録できる" do
        @item.price = 50000
        expect(@item).to be_valid
      end

      it "priceが半角英数字であれば登録できる" do
        @item.price = 50000
        expect(@item).to be_valid
      end
    end




    # 異常系
    context '商品出品がうまくいかないとき' do
      it "imageが空だと登録できない" do
        @item.image = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Image can't be blank")
      end

      it "nameが空であれば登録できない" do
        @item.name = ""
        @item.valid?
        expect(@item.errors.full_messages).to include("Name can't be blank")
      end

      it "descriptionが空では登録できない" do
        @item.description = ""
        @item.valid?
        expect(@item.errors.full_messages).to include("Description can't be blank")
      end

      it "category_idが空では登録できない" do
        @item.category_id = ""
        @item.valid?
        expect(@item.errors.full_messages).to include("Category can't be blank", "Category 選択して下さい")
      end

      it "status_idが空では登録できない" do
        @item.status_id = ""
        @item.valid?
        expect(@item.errors.full_messages).to include("Status can't be blank", "Status 選択して下さい")
      end

      it "delivery_charge_idが空では登録できない" do
        @item.delivery_charge_id = ""
        @item.valid?
        expect(@item.errors.full_messages).to include("Delivery charge can't be blank", "Delivery charge 選択して下さい")
      end

      it "area_idが空では登録できない" do
        @item.area_id = ""
        @item.valid?
        expect(@item.errors.full_messages).to include("Area can't be blank", "Area 選択して下さい")
      end

      it "days_idが空では登録できない" do
        @item.days_id = ""
        @item.valid?
        expect(@item.errors.full_messages).to include("Days can't be blank", "Days 選択して下さい")
      end

      it "priceが空では登録できない" do
        @item.price = ""
        @item.valid?
        expect(@item.errors.full_messages).to include("Price can't be blank", "Price 商品の価格は¥300~¥9999999で登録してください", "Price 半角数字で入力してください")
      end

      it "priceが9999999円以下でないと登録できない" do
        @item.price = 100000000
        @item.valid?
        expect(@item.errors.full_messages).to include("Price 商品の価格は¥300~¥9999999で登録してください")
      end

      it "priceが300円以上でないと登録できない" do
        @item.price = 200
        @item.valid?
        expect(@item.errors.full_messages).to include("Price 商品の価格は¥300~¥9999999で登録してください")
      end

      it "category_idが1では登録できない" do
        @item.category_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Category 選択して下さい")
      end

      it "status_idが1では登録できない" do
        @item.status_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Status 選択して下さい")
      end

      it "delivery_charge_idが1では登録できない" do
        @item.delivery_charge_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Delivery charge 選択して下さい")
      end

      it "area_idが1では登録できない" do
        @item.area_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Area 選択して下さい")
      end

      it "days_idが1では登録できない" do
        @item.days_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Days 選択して下さい")
      end
    end
  end
end