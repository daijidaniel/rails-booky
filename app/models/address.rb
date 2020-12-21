class Address < ApplicationRecord
  belongs_to :user, dependent: :destroy
  phony_normalize :phone, default_country_code: 'US'
end
