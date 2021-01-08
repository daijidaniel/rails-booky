class Address < ApplicationRecord
  belongs_to :user
  phony_normalize :phone, default_country_code: 'PL'
end
