class Device < ApplicationRecord
  belongs_to :restaurant
  has_many :registers, dependent: :destroy

  after_save :create_register
  
  validates :name, presence: true
  validates :status, presence: true

  validates :status, presence: true, inclusion: { in: %w(maintenance active), message: "%{value} no es válido para status" }
  

  private
    def create_register
      Register.create(device: self, status: self.status)
    end
end
