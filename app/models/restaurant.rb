class Restaurant < ApplicationRecord
    has_many :devices, dependent: :destroy
    validates :name, presence: true
    validates :status, presence: true
end
