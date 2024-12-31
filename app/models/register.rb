class Register < ApplicationRecord
  belongs_to :device
  validates :status, presence: true
end  

