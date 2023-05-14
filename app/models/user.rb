class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :post_likes, dependent: :destroy
  has_many :liked_posts, through: :post_likes, source: :post

  validates :username, presence: true, length: { maximum: 36 }, uniqueness: true
end
