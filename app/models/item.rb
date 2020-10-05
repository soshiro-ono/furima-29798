class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :user
  has_one_attached :image
  belongs_to_active_hash :category
  belongs_to_active_hash :status
  belongs_to_active_hash :delivery_charge
  belongs_to_active_hash :area
  belongs_to_active_hash :days

  validates :name, :description, :category_id,:status_id,:delivery_charge_id,:area_id,:days_id,:price, presence: true

  validates :category_id,:status_id,:delivery_charge_id,:area_id,:days_id, numericality: { other_than: 1 } 

end
