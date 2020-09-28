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
|image|text|null: false|
|name|string|null: false|
|description|text|null: false|
|category_id|string|null: false|
|status_id|string|null: false|
|delivery_charge_id|string|null: false|
|area_id|string|null: false|
|days_id|string|null: false|
|price|integer|null: false|


### Assosiation
- belong_to : users
- has_one : orders







# order table
|Column|Type|Option|
|------|----|------|
|user|references|null: false, foreign_key: true|
|item|references|null: false, foreign_key: true|


### Assosiation
belongs_to : users
belongs_to : items
has_one : addresses





# addresses table
|Column|Type|Option|
|------|----|------|
|order|references|null: false, foreign_key: true|
|postal_code|string|null: false|
|prefectures_id|string|null: false|
|municipality|string|null: false|
|address|string|null: false|
|building|string|
|phone|integer|null: false|a

### Assosiation
belongs_to : order

