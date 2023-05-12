class Comment < ApplicationRecord
  default_scope { order(created_at: :desc) }

  belongs_to :post
  belongs_to :user

  validates :body, presence: true, length: { maximum: 500 }
end
