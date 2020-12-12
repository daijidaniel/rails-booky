class Unit < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged
  monetize :price_cents

  has_many :unit_bookings, dependent: :delete_all
  has_many :bookings, through: :unit_bookings
  has_many_attached :images
  has_rich_text :description
  
  validates :name, presence: true
end
