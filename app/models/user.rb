class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :bookings
  has_one :address
  has_many :payments
  
  enum auth_level: %i[ user admin ]

  def name
    fname.to_s + " " + lname.to_s
  end
end
