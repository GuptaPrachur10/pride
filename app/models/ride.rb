class Ride < ApplicationRecord
  belongs_to :driver
  validates :from, presence: true, length: { maximum: 100 }
  validates :to, presence: true, length: { maximum: 100 }
  validates :price, presence: true
end
