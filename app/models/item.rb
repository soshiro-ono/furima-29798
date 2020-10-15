class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :user
  has_one :order

  has_one_attached :image
  belongs_to_active_hash :category
  belongs_to_active_hash :status
  belongs_to_active_hash :delivery_charge
  belongs_to_active_hash :area
  belongs_to_active_hash :days

  with_options presence: true do
    validates :image
    validates :name
    validates :description
    validates :category_id
    validates :status_id
    validates :delivery_charge_id
    validates :area_id
    validates :days_id
    validates :price
  end
  validates :price,numericality:{greater_than_or_equal_to:300,less_than_or_equal_to: 9999999,message:"商品の価格は¥300~¥9999999で登録してください"}

  validates :price,format: {with: /\A[0-9]+\z/, message: "半角数字で入力してください"}

  with_options numericality: { other_than: 1 ,message: "選択して下さい"} do
    validates :category_id
    validates :status_id
    validates :delivery_charge_id
    validates :area_id
    validates :days_id
  end  
end

   # validates :price,format:{with:/\A[a-zA-Z0-9]+\z/,greater_than_or_equal_to: 300,less_than_or_equal_to: 9999999,message:商品の価格は¥300~¥9999999で登録してください}