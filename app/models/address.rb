class Address < ApplicationRecord
  belongs_to :order
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :prefectures
  with_options presence: true do
    validates :postal_code
    validates :prefectures_id
    validates :municipality
    validates :address
    validates :building
    validates :phone
  end
  validates :prefectures_id, numericality: { other_than: 1 } 
# 郵便番号にはハイフンが必要であること（123-4567となる）
# 電話番号にはハイフンは不要で、11桁以内であること
end
