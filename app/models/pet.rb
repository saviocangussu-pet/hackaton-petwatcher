class Pet < ApplicationRecord
  belongs_to :owner, class_name: 'Person', foreign_key: :people_id
  belongs_to :specie
  has_one_attached :image
  has_many :sitter_services

  validates :name, presence: true
  validates :description, presence: true
end
