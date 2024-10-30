class SitterService < ApplicationRecord
  belongs_to :person
  belongs_to :pet

  validates :person, presence: true
  validates :pet, presence: true
  validates :start_date, presence: true
  validates :end_date, presence: true
  validates :total_rate, presence: true, numericality: { greater_than: 0 }

  before_validation :calculate_total_rate, on: :create

  private

  def calculate_total_rate
    total_seconds = (end_date.to_time - start_date.to_time).to_i
    total_hours = (total_seconds / ActiveSupport::Duration::SECONDS_PER_HOUR).ceil

    self.total_rate = total_hours * person.sitter_profile.rate
  end
end
