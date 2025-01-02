class Register < ApplicationRecord
  belongs_to :device
  validates :status, presence: true

  def restaurant_name
    device.restaurant.name
  end
end  

