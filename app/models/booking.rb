class Booking < ApplicationRecord
  ADULT_EXTRA_PRICE = 200
  CHILD_EXTRA_PRICE = 100

  belongs_to :user, required: false
  has_many :unit_bookings, dependent: :delete_all
  has_many :units, through: :unit_bookings
  monetize :price_cents

  has_many :additional_items
  has_many :items, through: :additional_items

  has_many :additional_variants
  has_many :variants, through: :additional_variants

  enum payment_status: %i[unpaid pending paid]

  accepts_nested_attributes_for :additional_items

  before_save :update_price

  def update_price
    total = 0
    
    total = units.map do |unit|
      unit.price_cents + extra_amount * 100
    end.sum * (end_date.to_date - start_date.to_date).to_i

    self.price_cents = total
  end

  def extra_amount
    if(self.adult_capacity + self.child_capacity) == 2
      return 0
    else
      return ( (self.adult_capacity - 2) < 0 ? 0 : (self.adult_capacity - 2) ) * ADULT_EXTRA_PRICE + child_capacity * CHILD_EXTRA_PRICE 
    end
  end
end
