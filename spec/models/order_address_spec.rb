require 'rails_helper'
RSpec.describe OrderAddress, type: :model do
  describe '購入情報の保存' do
    before do
      @order_address = FactoryBot.build(:order_address)
    end

    context '商品購入がうまくいくとき' do
      it "郵便番号、都道府県、市区町村、番地、電話番号、トークンがあれば保存ができること" do
        expect(@order_address).to be_valid
      end

      it "電話番号はハイフンなしの10または11桁なら登録できる" do
        @order_address.phone = "09087654321"
        expect(@order_address).to be_valid
      end

      it "郵便番号が半角英数字のハイフンを含んだ形あれば登録できる" do
        @order_address.postal_code = "123-1234"
        expect(@order_address).to be_valid
      end
    end
    # 異常系テスト

    context '商品購入がうまくいかない時' do
      it 'postal_codeが空だと保存できないこと' do
        @order_address.postal_code = ""
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Postal code 郵便番号にはハイフンが必要です")
      end
      it 'prefectures_idが1だと保存できないこと' do
        @order_address.prefectures_id = 1
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Prefectures must be other than 1")
      end
      it 'municipalityが空だと保存できないこと' do
        @order_address.municipality = ""
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Municipality can't be blank")
      end
      it 'addressが空だと保存できないこと' do
        @order_address.address = ""
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Address can't be blank")
      end
      it 'phoneが空だと保存できないこと' do
        @order_address.phone  = ""
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Phone can't be blank")
      end
      it 'phoneはハイフン不要で、半角数字11桁以内でないと保存できないこと' do
        @order_address.phone  = "111-1111-1111"
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Phone ハイフンは不要で、半角数字11桁以内にしてください")
      end
      it "tokenが空では登録できないこと" do
        @order_address.token = nil
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Token can't be blank")
      end
      it 'postal_codeが半角のハイフンを含んだ正しい形式でないと保存できないこと' do
        @order_address.postal_code = "1234567"
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Postal code 郵便番号にはハイフンが必要です")
      end
      it 'buildingは空でも保存できること' do
        @order_address.building = nil
        expect(@order_address).to be_valid
      end
    end
  end
end


