class Message < ApplicationRecord
  belongs_to :group
  belongs_to :user
  validates :body, presence: true, if: -> { image.blank? }
  validates :image, presence: true, if: -> { body.blank? }

  mount_uploader :image, ImageUploader
end
