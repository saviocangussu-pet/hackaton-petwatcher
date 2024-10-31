class Pet < ApplicationRecord
  belongs_to :owner, class_name: 'Person', foreign_key: :people_id
  belongs_to :specie
  has_one_attached :image
  has_many :sitter_services

  validates :name, presence: true
  validates :description, presence: true

  scope :by_owner_ids, -> (ids) { includes(:owner).where(people_id: ids) }

  scope :closests, lambda { |person|
    pet_columns = %w[pets.id pets.name pets.description pets.specie_id pets.people_id pets.created_at pets.updated_at]

    joins(owner: [:location])
      .select(
        pet_columns.join(', '), Location.distance_from_query(person.location.latitude, person.location.longitude)
      ).where.not(
        owner: { id: person.id }
      ).order(distance: :asc)
  }
end
