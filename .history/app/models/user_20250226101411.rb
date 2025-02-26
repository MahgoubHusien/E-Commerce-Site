class User < ApplicationRecord
  has_secure_password
  has_many :sessions, dependent: :destroy
  has_many :wishlist_items, dependent: :destroy
  # has_many :wishlist_products, through: :wishlist_items, source: :product

  normalizes :email_address, with: ->(e) { e.strip.downcase }
end
