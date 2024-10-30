class SitterProfile < ApplicationRecord
  belongs_to :person
  has_many :sitter_profile_species, class_name: 'SitterProfileSpecie'
  has_many :species, through: :sitter_profile_species, source: :specie

  validates :rate, presence: true, numericality: { greater_than: 0 }
  validates :description, presence: true, length: { minimum: 20 }
end
