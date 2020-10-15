class CreateAddresses < ActiveRecord::Migration[6.0]
  def change
    create_table :addresses do |t|
      t.references :order,null: false, foreign_key: true
      t.string :postal_code,null: false
      t.integer :prefectures_id,null: false
      t.string :municipality,null: false
      t.string :address,null: false
      t.string :building,null: false
      t.string :phone,null: false
    end
  end
end
