class Variant < ApplicationRecord
  has_one_attached :image
  monetize :price_cents
  has_rich_text :description

  belongs_to :item
end
