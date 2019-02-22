class Message < ApplicationRecord
  belongs_to :group, required: true
  belongs_to :user,  required: true
  validates :body,  presence: true, if: -> { image.blank? }
  validates :image, presence: true, if: -> { body.blank? }

  mount_uploader :image, ImageUploader
end
