class Post < ApplicationRecord
  default_scope { order(created_at: :desc) }

  belongs_to :user

  has_many :comments, dependent: :destroy

  has_one_attached :picture

  validates :title, presence: true, length: { maximum: 140 }
  validates :body, presence: true, length: { maximum: 2000 }
  validates :picture, content_type: %i[png jpg jpeg webp]
end
