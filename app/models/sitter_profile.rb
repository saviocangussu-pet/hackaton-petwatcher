class SitterProfile < ApplicationRecord
  has_many :species

  validates :rate, presence: true, numericality: { greater_than: 0 }
  validates :description, presence: true, length: { minimum: 20 }
end
