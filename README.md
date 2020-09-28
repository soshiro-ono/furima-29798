## users table
|Column|Type|Option|
|------|----|------|
|nickname|string|null: false|
|email|string|null: false|
|encrypted_password|string|null: false|
|family_name|string|null: false|
|last_name|string|null: false|
|family_katakana|string|null: false|
|last_katakana|string|null: false|
|birthday|date|null: false|


### Assosiation
- has_many :items
- has_many :orders



# items table
|Column|Type|Option|
|------|----|------|
|user_id|string|null: false, foreign_key: true|
|name|string|null: false|
|description|text|null: false|
|category_id|integer|null: false|
|status_id|integer|null: false|
|delivery_charge_id|integer|null: false|
|area_id|integer|null: false|
|days_id|integer|null: false|
|price|integer|null: false|


### Assosiation
- belong_to : user
- has_one : order







# orders table
|Column|Type|Option|
|------|----|------|
|user|references|null: false, foreign_key: true|
|item|references|null: false, foreign_key: true|


### Assosiation
belongs_to : user
belongs_to : item
has_one : address





# addresses table
|Column|Type|Option|
|------|----|------|
|order|references|null: false, foreign_key: true|
|postal_code|string|null: false|
|prefectures_id|integer|null: false|
|municipality|string|null: false|
|address|string|null: false|
|building|string|
|phone|string|null: false|

### Assosiation
belongs_to : order

