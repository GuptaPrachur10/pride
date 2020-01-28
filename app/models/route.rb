class Route < ApplicationRecord
  belongs_to :rider
  validates :from, presence: true, length: { maximum: 100 }
  validates :to, presence: true, length: { maximum: 100 }
end
