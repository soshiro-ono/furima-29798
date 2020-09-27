## users table
|Column|Type|Option|
|------|----|------|
|nickname|string|null: false|
|e-mail|string|null: false|
|password|string|null: false|
|family-name|string|null: false|
|last-name|string|null: false|
|birthday|string|null: false|

### Assosiation
- has_many :items
- has_many :orders


# items table
|Column|Type|Option|
|------|----|------|
|user-id|string|null: false, foreign_key: true|
|price|integer|null: false|
|content|string|null: false|
<!-- |content|string| -->
|name|string|null: false|
|description|string|null: false|
|category|string|null: false|
|delivery|string|null: false|

### Assosiation
- belong_to : users
- has_one : orders

# order table
|Column|Type|Option|
|------|----|------|
|user-id|references|null: false, foreign_key: true|
|item-id|references|null: false, foreign_key: true|
|address|string|null: false|


### Assosiation
belongs_to : users
belongs_to : items

<!-- # sample4 table
|Column|Type|Option|
|------|----|------|
|text|string|null: false| -->