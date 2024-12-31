class Device < ApplicationRecord
  belongs_to :restaurant
  validates :name, presence: true
  validates :status, presence: true
end
