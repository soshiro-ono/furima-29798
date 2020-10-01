class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # バリデーションを書いていく
  # validates :nickname,presence: true
  # validates :family_name,/\A[ぁ-んァ-ン一-龥]/
  # validates :last_name,/\A[ぁ-んァ-ン一-龥]/
  # validates :family_katakana,/\A[ァ-ヶー－]+\z/
  # validates :last_katakana,/\A[ァ-ヶー－]+\z/
  # validates :encrypted_password,/\A(?=.*?[a-z])(?=.*?[\d])[a-z\d]+\z/i
  # validates :encrypted_password,2kaimenonyuuryoku
  # validates :encrypted_password,length: { minimum: 6 }
  # validates :email,@fukumu
  # validates :birthday,presence: true
end
