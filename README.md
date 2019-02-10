# Database

## users table

|Column|Type|Options|
|------|----|-------|
|name|string|index: true, null: false|
|email|string|null: false, unique: true|

### Association
- has_many :groups, through: :members

## groups table

|Column|Type|Options|
|------|----|-------|
|name|string|null: false|

### Association
- has_many :users, through: :members

## members table

|Column|Type|Options|
|------|----|-------|
|user_id|integer|index: true, null: false, foreign_key: true|
|group_id|integer|index: true, null: false, foreign_key: true|

### Association
- belongs_to :group
- belongs_to :user

## messages table

|Column|Type|Options|
|------|----|-------|
|body|string|null: false|
|image|string||
|user_id|integer|null: false, foreign_key: true|
|group_id|integer|null: false, foreign_key: true|

### Association
- belongs_to :group
- belongs_to :user
