class Restaurant < ApplicationRecord
    validates :name, presence: true
    validates :status, presence: true
end
