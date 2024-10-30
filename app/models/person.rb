class Person < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates_presence_of :name, :email, :phone

  belongs_to :location, dependent: :destroy

  has_one :sitter_profile

  has_one_attached :profile_image

  has_many :sitter_services, dependent: :destroy

  has_many :pets, dependent: :destroy, foreign_key: :people_id

  accepts_nested_attributes_for :sitter_profile, :location

  scope :sitters, -> { where(sitter: true) }
  scope :closests, lambda { |location|
    record = joins_values.include?(:location) ? self : joins(:location)
    record.select('*', Location.distance_from_query(location.latitude, location.longitude))
          .order(distance: :asc)
  }
end
