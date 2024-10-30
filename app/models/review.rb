class Review < ApplicationRecord
  belongs_to :reviewable, polymorphic: true
  belongs_to :person

  validates :stars, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 5 }
  validates :comment, length: { in: 10..300 }
end
