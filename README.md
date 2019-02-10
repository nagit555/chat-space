# Database

## users table

|Column|Type|Options|
|------|----|-------|
|name|string|index: true, presence: true|
|email|string|presence: true, unique: true|

### Association
- has_many :groups, through: :members

## groups table

|Column|Type|Options|
|------|----|-------|
|name|string|presence: true|

### Association
- has_many :users, through: :members

## members table

|Column|Type|Options|
|------|----|-------|
|user_id|integer|index: true, presence: true, foreign_key: true|
|group_id|integer|index: true, presence: true, foreign_key: true|

### Association
- belongs_to :group
- belongs_to :user

## messages table

|Column|Type|Options|
|------|----|-------|
|body|string|presence: true, if: -> { image.blank? }|
|image|string|presence: true, if: -> { body.blank? }|
|user_id|integer|presence: true, foreign_key: true|
|group_id|integer|presence: true, foreign_key: true|

### Association
- belongs_to :group
- belongs_to :user
