class SitterService < ApplicationRecord
  belongs_to :person
  belongs_to :pet

  validates :person, presence: true
  validates :pet, presence: true
  validates :start_date, presence: true
  validates :end_date, presence: true
  validates :total_rate, presence: true, numericality: { greater_than: 0 }
end