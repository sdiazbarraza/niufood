class Device < ApplicationRecord
  belongs_to :restaurant
  has_many :registers, dependent: :destroy
  
  validates :name, presence: true
  validates :status, presence: true

  validates :status, presence: true, inclusion: { in: %w(maintenance active), message: "%{value} no es válido para status" }

end
