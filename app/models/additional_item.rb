class AdditionalItem < ApplicationRecord
  belongs_to :booking, required: false
  belongs_to :item, required: false
end
