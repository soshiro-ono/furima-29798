class OrderAddress
  include ActiveModel::Model
  attr_accessor :postal_code, :prefectures_id, :municipality, :address, :building, :phone,:item_id,:user_id,:token
  #このattr_accessorの意味を理解する
  with_options presence: true do
    validates :postal_code
    validates :prefectures_id
    validates :municipality
    validates :address
    validates :phone
    validates :token
  end

  validates :prefectures_id, numericality: { other_than: 1 } 
  validates :postal_code, format: {with: /\A[0-9]{3}-[0-9]{4}\z/, message: "郵便番号にはハイフンが必要です"}
  # 郵便番号にはハイフンが必要であること（123-4567となる）
  validates :phone, format: {with: /\A\d{10,11}\z/, message: "ハイフンは不要で、半角数字11桁以内にしてください"}
  # 電話番号にはハイフンは不要で、11桁以内であること

  def save
    order = Order.create(item_id: item_id, user_id: user_id)
    # 住所の情報を保存
    Address.create(order_id: order.id, postal_code: postal_code, prefectures_id: prefectures_id, municipality: municipality, address: address, building: building, phone: phone)
  end
end