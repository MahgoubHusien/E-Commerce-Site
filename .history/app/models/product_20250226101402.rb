class Product < ApplicationRecord
  include Notifications

  has_many :subscribers, dependent: :destroy
  has_one_attached :featured_image
  has_rich_text :description
  has_many :wishlist_items, dependent: :destroy
  has_many :wishlisted_by_users, through: :wishlist_items, source: :user

  validates :name, presence: true
  validates :inventory_count, numericality: { greater_than_or_equal_to: 0 }
end
