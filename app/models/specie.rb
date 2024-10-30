# frozen_string_literal: true

class Specie < ApplicationRecord
  has_many :people_species
  has_many :persons, through: :people_species

  DOG = 'dog'
  CAT = 'cat'
  SPECIES = [DOG, CAT].freeze

  validates :name, inclusion: { in: SPECIES }

  scope :dogs, -> { where(species: DOG) }
  scope :cats, -> { where(species: CAT) }
end
