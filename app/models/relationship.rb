class Relationship < ApplicationRecord
  belongs_to :rider, class_name: "Rider"
  belongs_to :driver, class_name: "Driver"
  validates :rider_id, presence: true
  validates :driver_id, presence: true
end
