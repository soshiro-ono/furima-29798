class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :items
  has_many :orders

  with_options presence: true do
    validates :nickname
    validates :family_name,format: {with:/\A[ぁ-んァ-ン一-龥]/, message:"全角で入力してください"}
    validates :last_name,format: {with:/\A[ぁ-んァ-ン一-龥]/, message:"全角で入力してください"}
    validates :family_katakana,format: {with:/\A[ァ-ヶー－]+\z/, message:"全角カタカナで入力してください"}
    validates :last_katakana,format: {with:/\A[ァ-ヶー－]+\z/, message:"全角カタカナで入力してください"}
    validates :password,format: {with:/\A[a-zA-Z0-9]+\z/,length:{minimum:6}, message:"パスワードは6文字以上で半角英数字混合で入力してください"}
    validates :birthday
  end
end


# パスワードに関してはpasswordとpassword_confirmationを使う？
# そもそもなぜパスワードはデバイスで設定しているのにpasswordとpassword_confirmationを使うにか
#{6,}/i