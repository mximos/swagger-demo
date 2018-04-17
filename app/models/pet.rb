class Pet < ApplicationRecord
  validates :name, :status, presence: true
end
