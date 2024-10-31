class Person < ApplicationRecord
  DEFAULT_DISTANCE_UNIT = :km

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates_presence_of :name, :email, :phone

  belongs_to :location, dependent: :destroy

  has_one :sitter_profile, dependent: :destroy
  has_one_attached :profile_image

  has_many :sitter_services, dependent: :destroy
  has_many :pets, dependent: :destroy, inverse_of: :owner

  accepts_nested_attributes_for :sitter_profile, update_only: true
  accepts_nested_attributes_for :location
  accepts_nested_attributes_for :pets

  scope :sitters, -> { where(sitter: true) }
  scope :owners, -> { where(sitter: false) }
  scope :pet_owners, -> { where(owner: true) }
  scope :closests, lambda { |person|
    distance_query = Location.distance_from_query(
      person.location.latitude,
      person.location.longitude,
      unit: person.fetch_distance_unit
    )

    record = joins_values.include?(:location) ? self : joins(:location)
    record.select('*', *distance_query)
          .order(distance: :asc)
  }

  def fetch_distance_unit
    (distance_unit || DEFAULT_DISTANCE_UNIT).to_s.to_sym
  end

  def closest_sitters
    Person.sitters.closests(self).where.not(id:)
  end
end
