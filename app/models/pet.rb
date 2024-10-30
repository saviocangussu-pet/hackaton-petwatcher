class Pet < ApplicationRecord
  belongs_to :owner, class_name: 'Person', foreign_key: :people_id
  belongs_to :specie
  has_one_attached :image
  has_many :sitter_services

  validates :name, presence: true
  validates :description, presence: true

  scope :by_owner_ids, -> (ids) { includes(:owner).where(people_id: ids) }

  scope :closests, lambda { |person|
    joins(owner: [:location])
      .select(
        '*', Location.distance_from_query(person.location.latitude, person.location.longitude)
      ).where.not(
        owner: { id: person.id }
      ).order(distance: :asc)
  }
end
