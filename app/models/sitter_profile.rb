class SitterProfile < ApplicationRecord
  belongs_to :location, dependent: :destroy
  has_many :species

  accepts_nested_attributes_for :location
end
