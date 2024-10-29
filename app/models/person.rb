class Person < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one :sitter_profile

  has_many :pets, dependent: :destroy, foreign_key: :people_id

  accepts_nested_attributes_for :sitter_profile

  scope :sitters, -> { where(sitter: true) }
  scope :closests, lambda { |location|
    record = joins_values.include?(sitter_profile: :location) ? self : joins(sitter_profile: :location)
    record.select('*', Location.distance_from_query(location.latitude, location.longitude))
          .order(distance: :asc)
  }
end
