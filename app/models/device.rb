class Device < ApplicationRecord
  belongs_to :restaurant
  has_many :registers, dependent: :destroy

  after_save :create_register
  after_destroy :delete_status_device
  validates :name, presence: true
  validates :status, presence: true

  validates :status, presence: true, inclusion: { in: %w(maintenance active), message: "%{value} no es válido para status" }
  

  private
    def create_register
      Register.create(device: self, status: self.status)
    end

    def delete_status_device
      Register.create(device: self, status: "deleted")
    end
end
