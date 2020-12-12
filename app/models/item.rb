class Item < ApplicationRecord
  monetize :price_cents
  has_rich_text :description

  has_many_attached :images
  has_many :additional_items
  has_many :bookings, through: :additional_items
  has_many :variants

  accepts_nested_attributes_for :variants
end
