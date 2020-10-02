require 'rails_helper'
describe User do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    context '新規登録がうまくいくとき' do
      it "nickname、email、password、password_confirmation、family_name、last_name、family_katakana、last_katakana、birth_dayが存在すれば登録できる" do
        expect(@user).to be_valid
      end
      it "family_nameとlast_nameが全角あれば登録できる" do
        @user.family_name = "小野"
        @user.last_name = "太郎"
        expect(@user).to be_valid
      end
      it "family_katakanaとlast_katakanaが全角カタカナあれば登録できる" do
        @user.family_katakana = "オノ"
        @user.last_katakana = "タロウ"
        expect(@user).to be_valid
      end
      it "passwordは6文字以上で半角英数字混合であれば登録できる"do
        @user.password = "7749os"
        @user.password_confirmation = "7749os"
        expect(@user).to be_valid
      end
      it "メールアドレスは@を含んでいれば登録できる"do
        @user.email = ooo@kkk
        expect(@user).to be_valid
      end
    end


    # 異常系テスト
    context '新規登録がうまくいかないとき' do
      it "nicknameが空だと登録できない" do
        @user.nickname = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Nickname can't be blank")
      end

      it "family_nameは全角でなければ登録できない" do
        @user.family_name = "aaa"
        @user.valid?
        expect(@user.errors.full_messages).to include("Family name 全角で入力してください")
      end

      it "last_nameは全角でなければ登録できない" do
        @user.last_name = "bbb"
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name 全角で入力してください")
      end


      it "family_katakanaは全角カタカナでなければであれば登録できない" do
        @user.family_katakana = "ccc"
        @user.valid?
        expect(@user.errors.full_messages).to include("Family katakana 全角カタカナで入力してください")
      end

      it "last_katakanaは全角カタカナでなければであれば登録できない" do
        @user.last_katakana = "ddd"
        @user.valid?
        expect(@user.errors.full_messages).to include("Last katakana 全角カタカナで入力してください")
      end

      it "emailが空では登録できない" do
        @user.email = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Email can't be blank")
      end

      it "重複したemailが存在する場合登録できない" do
        @user.save
          another_user = FactoryBot.build(:user)
          another_user.email = @user.email
          another_user.valid?
          expect(another_user.errors.full_messages).to include("Email has already been taken")
      end

      it "passwordが空では登録できない" do
        @user.password = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be blank")
      end

      it "passwordが5文字以下であれば登録できない" do
        @user.password = "9i9i9"
        @user.valid?
        expect(@user.errors.full_messages).to include("Password is too short (minimum is 6 characters)")
      end

      it "passwordが存在してもpassword_confirmationが空では登録できない" do
        @user.password_confirmation = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end

      it "passwordが存在してもpassword_confirmationと一致していなければ登録できない" do
        @user.password_confirmation = "44rr4r"
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end

      it "passwordは英数字混合でなければ登録できない" do
        @user.password = "pppppp"
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end
    end
  end
end